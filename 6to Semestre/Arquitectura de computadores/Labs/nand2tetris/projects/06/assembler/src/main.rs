use std::collections::HashMap;
use std::env;
use std::fs::File;
use std::io::{BufRead, BufReader, Write};

#[derive(Debug)]
enum Instruction {
    Label,
    TypeA,
    TypeC,
}

struct HackParser {
    cur_mem_pos: usize,
    parser_info: ParserInfo,
}

impl HackParser {
    pub fn new() -> HackParser {
        HackParser {
            cur_mem_pos: 15,
            parser_info: ParserInfo::default(),
        }
    }

    pub fn assemble(&mut self, path: &str) {
        let mut reader: BufReader<File> =
            BufReader::new(File::open(&path).expect("Error! File not found"));

        self.handle_labels(&mut reader);

        let mut reader: BufReader<File> =
            BufReader::new(File::open(&path).expect("Error! File not found"));
        let mut out_file: File =
            File::create(&path.replace(".asm", ".hack")).expect("Error! Could not create file");

        self.parse_file(&mut reader, &mut out_file);
    }

    fn handle_labels(&mut self, reader: &mut BufReader<File>) {
        let mut index = 0;

        for line in reader.lines() {
            match line {
                Ok(instruction) => match self.selector(&instruction) {
                    Some(Instruction::Label) => {
                        self.add_to_table(instruction[1..instruction.len() - 1].to_string(), index);
                    }
                    Some(_) => index += 1,
                    None => (),
                },
                Err(_) => (),
            }
        }
    }

    fn parse_file(&mut self, reader: &mut BufReader<File>, out_file: &mut File) {
        for line in reader.lines() {
            match line {
                Ok(instruction) => match self.selector(&instruction) {
                    Some(Instruction::TypeA) => {
                        out_file
                            .write_fmt(format_args!(
                                "{}\n",
                                self.parse_type_a(&self.format_line(&instruction).unwrap())
                            ))
                            .unwrap();
                    }
                    Some(Instruction::TypeC) => {
                        out_file
                            .write_fmt(format_args!("{}\n", self.parse_type_c(&instruction)))
                            .unwrap();
                    }
                    Some(Instruction::Label) => (),
                    None => (),
                },
                Err(_) => todo!(),
            }
        }
    }

    fn selector(&self, instruction: &str) -> Option<Instruction> {
        let inst = match self.format_line(instruction) {
            Some(formatted) => match formatted.chars().next() {
                Some('@') => Some(Instruction::TypeA),
                Some('(') => Some(Instruction::Label),
                Some(_) => Some(Instruction::TypeC),
                None => None,
            },
            None => None,
        };
        inst
    }

    fn format_line(&self, unformated: &str) -> Option<String> {
        match unformated.split("//").next() {
            Some("") => None,
            Some(line) => Some(line.trim().to_string()),
            None => None,
        }
    }

    fn add_to_table(&mut self, k: String, pos: usize) {
        self.parser_info.add_to_table(k, pos);
    }

    fn parse_type_a(&mut self, type_a: &String) -> String {
        let type_a = &type_a.replace("@", "");

        match type_a.parse::<usize>().is_ok() {
            true => {
                let bin_a = format!("{:b}", type_a.parse::<usize>().unwrap());
                format!("{}{}", "0".repeat(16 - bin_a.len()), bin_a)
            }
            false => match self.parser_info.symb.get(type_a) {
                Some(value) => {
                    let bin_a = format!("{:b}", value);
                    format!("{}{}", "0".repeat(16 - bin_a.len()), bin_a)
                }
                None => {
                    self.cur_mem_pos += 1;
                    self.add_to_table(type_a.clone(), self.cur_mem_pos);
                    let bin_a = format!("{:b}", self.cur_mem_pos);
                    format!("{}{}", "0".repeat(16 - bin_a.len()), bin_a)
                }
            },
        }
    }

    fn parse_type_c(&self, type_c: &String) -> String {
        let type_c = &self.format_line(type_c).unwrap();
        let normalized = self.normalize_type_c(type_c);

        let split = normalized.split("=").collect::<Vec<&str>>();
        let rem = split[1].split(";").collect::<Vec<&str>>();

        let dest = self
            .parser_info
            .dest
            .get(split[0].trim())
            .expect("DEST ERROR");
        let comp = self
            .parser_info
            .comp
            .get(rem[0].trim())
            .expect("COMP ERROR");
        let jump = self
            .parser_info
            .jump
            .get(rem[1].trim())
            .expect("JUMP ERROR");

        format!("111{}{}{}", comp, dest, jump)
    }

    fn normalize_type_c(&self, type_c: &String) -> String {
        let half_normalized: String;
        let normalized: String;

        if !type_c.contains("=") {
            half_normalized = format!("{}{}", "none=", type_c);
        } else {
            half_normalized = type_c.clone();
        }

        if !type_c.contains(";") {
            normalized = format!("{}{}", half_normalized, ";none");
        } else {
            normalized = half_normalized.clone();
        }

        return normalized;
    }
}

struct ParserInfo {
    symb: HashMap<String, usize>,
    jump: HashMap<String, String>,
    dest: HashMap<String, String>,
    comp: HashMap<String, String>,
}

impl ParserInfo {
    pub fn _new() -> ParserInfo {
        ParserInfo {
            symb: HashMap::new(),
            jump: HashMap::new(),
            dest: HashMap::new(),
            comp: HashMap::new(),
        }
    }

    pub fn add_to_table(&mut self, k: String, pos: usize) {
        match self.symb.get(&k) {
            Some(_) => (),
            None => {
                self.symb.insert(k, pos);
            }
        }
    }
}

impl Default for ParserInfo {
    fn default() -> ParserInfo {
        ParserInfo {
            symb: vec![
                ("SP".to_string(), 0),
                ("LCL".to_string(), 1),
                ("ARG".to_string(), 2),
                ("THIS".to_string(), 3),
                ("THAT".to_string(), 4),
                ("SCREEN".to_string(), 16384),
                ("KBD".to_string(), 24576),
                ("R0".to_string(), 0),
                ("R1".to_string(), 1),
                ("R2".to_string(), 2),
                ("R3".to_string(), 3),
                ("R4".to_string(), 4),
                ("R5".to_string(), 5),
                ("R6".to_string(), 6),
                ("R7".to_string(), 7),
                ("R8".to_string(), 8),
                ("R9".to_string(), 9),
                ("R10".to_string(), 10),
                ("R11".to_string(), 11),
                ("R12".to_string(), 12),
                ("R13".to_string(), 13),
                ("R14".to_string(), 14),
                ("R15".to_string(), 15),
            ]
            .into_iter()
            .collect(),
            jump: vec![
                ("none".to_string(), "000".to_string()),
                ("JGT".to_string(), "001".to_string()),
                ("JEQ".to_string(), "010".to_string()),
                ("JGE".to_string(), "011".to_string()),
                ("JLT".to_string(), "100".to_string()),
                ("JNE".to_string(), "101".to_string()),
                ("JLE".to_string(), "110".to_string()),
                ("JMP".to_string(), "111".to_string()),
            ]
            .into_iter()
            .collect(),
            dest: vec![
                ("none".to_string(), "000".to_string()),
                ("M".to_string(), "001".to_string()),
                ("D".to_string(), "010".to_string()),
                ("A".to_string(), "100".to_string()),
                ("MD".to_string(), "011".to_string()),
                ("AM".to_string(), "101".to_string()),
                ("AD".to_string(), "110".to_string()),
                ("AMD".to_string(), "111".to_string()),
            ]
            .into_iter()
            .collect(),
            comp: vec![
                ("none".to_string(), "1111111".to_string()),
                ("0".to_string(), "0101010".to_string()),
                ("1".to_string(), "0111111".to_string()),
                ("-1".to_string(), "0111010".to_string()),
                ("D".to_string(), "0001100".to_string()),
                ("A".to_string(), "0110000".to_string()),
                ("!D".to_string(), "0001101".to_string()),
                ("!A".to_string(), "0110001".to_string()),
                ("-D".to_string(), "0001111".to_string()),
                ("-A".to_string(), "0110011".to_string()),
                ("D+1".to_string(), "0011111".to_string()),
                ("A+1".to_string(), "0110111".to_string()),
                ("D-1".to_string(), "0001110".to_string()),
                ("A-1".to_string(), "0110010".to_string()),
                ("D+A".to_string(), "0000010".to_string()),
                ("D-A".to_string(), "0010011".to_string()),
                ("A-D".to_string(), "0000111".to_string()),
                ("D&A".to_string(), "0000000".to_string()),
                ("D|A".to_string(), "0010101".to_string()),
                ("M".to_string(), "1110000".to_string()),
                ("!M".to_string(), "1110001".to_string()),
                ("-M".to_string(), "1110011".to_string()),
                ("M+1".to_string(), "1110111".to_string()),
                ("M-1".to_string(), "1110010".to_string()),
                ("D+M".to_string(), "1000010".to_string()),
                ("D-M".to_string(), "1010011".to_string()),
                ("M-D".to_string(), "1000111".to_string()),
                ("D&M".to_string(), "1000000".to_string()),
                ("D|M".to_string(), "1010101".to_string()),
            ]
            .into_iter()
            .collect(),
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = &args[1];

    HackParser::new().assemble(&path);
}
