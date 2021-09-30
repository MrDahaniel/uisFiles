pub mod asm;

use regex;
use std::borrow::BorrowMut;
use std::collections::HashMap;
use std::env;
use std::fmt::Error;
use std::fs::File;
use std::io::BufReader;
use std::result::Result;

enum R {
    Ok,
    Err,
}

struct HackParser {
    cur_mem_pos: usize,
    parser_info: ParserInfo,
    reader: Option<BufReader<File>>,
    out_file: Option<&'static mut File>,
}

impl HackParser {
    pub fn new(path: String) -> HackParser {
        HackParser {
            cur_mem_pos: 15,
            parser_info: ParserInfo::default(),
            reader: None,
            out_file: None,
        }
    }

    pub fn assemble(self, path: String) -> R {
        match self.load_file(path) {
            R::Ok => (),
            R::Err => return R::Err,
        }

        match self.parse_file() {
            R::Ok => (),
            R::Err => {
                println!("Error parsing file!");
                return R::Err;
            }
        }

        R::Ok
    }

    fn load_file(self, path: String) -> R {
        match File::open(path) {
            Ok(file) => self.reader = Some(BufReader::new(file)),
            Err(_) => {
                println!("Error! File not found.");
                return R::Err;
            }
        }

        match File::create(path.replace(".asm", ".hack")) {
            Ok(out_file) => self.out_file,
            Err(_) => {
                println!("Error! File not found.");
                return R::Err;
            }
        };

        R::Ok
    }

    fn parse_file(self) -> R {
        R::Ok
    }

    fn selector(self, instruction: &'static str) {
        match instruction.strip_prefix("@") {
            Some(ins) => self.parse_a_type(instruction),
            None => {}
        }
    }

    fn parse_a_type(self, instruction: &'static str) {}

    fn add_to_table(self, k: &'static str) {
        self.cur_mem_pos += 1;
        match self.parser_info.add_to_table(k, self.cur_mem_pos) {
            R::Ok => (),
            R::Err => {
                self.cur_mem_pos -= 1;
            }
        };
    }
}

struct ParserInfo {
    pub symb: &'static mut HashMap<&'static str, usize>,
    pub jump: HashMap<&'static str, &'static str>,
    pub dest: HashMap<&'static str, &'static str>,
    pub comp: HashMap<&'static str, &'static str>,
}

impl ParserInfo {
    pub fn new() -> ParserInfo {
        ParserInfo {
            symb: &mut HashMap::new(),
            jump: HashMap::new(),
            dest: HashMap::new(),
            comp: HashMap::new(),
        }
    }

    pub fn add_to_table(self, k: &'static str, pos: usize) -> R {
        match self.symb.get(k) {
            Some(_) => R::Err,
            None => {
                self.symb.insert(k, pos);
                R::Ok
            }
        }
    }
}

impl Default for ParserInfo {
    fn default() -> ParserInfo {
        ParserInfo {
            symb: vec![
                ("SP", 0),
                ("LCL", 1),
                ("ARG", 2),
                ("THIS", 3),
                ("THAT", 4),
                ("SCREEN", 16384),
                ("KBD", 24576),
                ("R0", 0),
                ("R1", 1),
                ("R2", 2),
                ("R3", 3),
                ("R4", 4),
                ("R5", 5),
                ("R6", 6),
                ("R7", 7),
                ("R8", 8),
                ("R9", 9),
                ("R10", 10),
                ("R11", 11),
                ("R12", 12),
                ("R13", 13),
                ("R14", 14),
                ("R15", 15),
            ]
            .into_iter()
            .collect::<HashMap<&str, usize>>()
            .borrow_mut(),
            jump: vec![
                ("null", "000"),
                ("JGT", "001"),
                ("JEQ", "010"),
                ("JGE", "011"),
                ("JLT", "100"),
                ("JNE", "101"),
                ("JLE", "110"),
                ("JMP", "111"),
            ]
            .into_iter()
            .collect(),
            dest: vec![
                ("none", "000"),
                ("M", "001"),
                ("D", "010"),
                ("A", "100"),
                ("MD", "011"),
                ("AM", "101"),
                ("AD", "110"),
                ("AMD", "111"),
            ]
            .into_iter()
            .collect(),
            comp: vec![
                ("0", "0101010"),
                ("1", "0111111"),
                ("-1", "0111010"),
                ("D", "0001100"),
                ("A", "0110000"),
                ("!D", "0001101"),
                ("!A", "0110001"),
                ("-D", "0001111"),
                ("-A", "0110011"),
                ("D+1", "0011111"),
                ("A+1", "0110111"),
                ("D-1", "0001110"),
                ("A-1", "0110010"),
                ("D+A", "0000010"),
                ("D-A", "0010011"),
                ("A-D", "0000111"),
                ("D&A", "0000000"),
                ("D|A", "0010101"),
                ("M", "1110000"),
                ("!M", "1110001"),
                ("-M", "1110011"),
                ("M+1", "1110111"),
                ("M-1", "1110010"),
                ("D+M", "1000010"),
                ("D-M", "1010011"),
                ("M-D", "1000111"),
                ("D&M", "1000000"),
                ("D|M", "1010101"),
            ]
            .into_iter()
            .collect(),
        }
    }
}

struct TypeAIns {
    address: String,
}

impl TypeAIns {
    pub fn new(address: String) -> Result<TypeAIns, Error> {
        let re = regex::Regex::new("/^0[0-1]+/gm").unwrap();
        match address.len() {
            16 => match re.is_match(&address) {
                true => Ok(TypeAIns { address }),
                false => Err(Error::default()),
            },
            _ => Err(Error::default()),
        }
    }

    pub fn to_string(self) -> String {
        self.address
    }

    pub fn format(self, unformated_string: String) -> Result<TypeAIns, Error> {
        let re = regex::Regex::new("/[0-1]+/gm").unwrap();
        match unformated_string.len() <= 16 && re.is_match(&unformated_string) {
            true => Ok(TypeAIns {
                address: format!(
                    "{}{}",
                    "0".repeat(16 - unformated_string.len()),
                    unformated_string
                ),
            }),
            false => Err(Error::default()),
        }
    }

    pub fn from_usize(self, uaddress: usize) -> Result<TypeAIns, Error> {
        self.format(format!("{:b}", uaddress))
    }
}

struct TypeCIns {
    header: String,
    comp: String,
    dest: String,
    jump: String,
}

impl TypeCIns {
    pub fn new(comp: String, dest: String, jump: String) -> TypeCIns {
        TypeCIns {
            header: String::from("111"),
            comp,
            dest,
            jump,
        }
    }

    pub fn to_string(self) -> String {
        format!("{}{}{}{}", self.header, self.comp, self.dest, self.jump)
    }
}

enum Instruction {
    TypeA(TypeAIns),
    TypeC(TypeCIns),
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = &args[1];

    // asm::assembler::assemble(reader, out_file);
}
