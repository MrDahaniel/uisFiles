use std::borrow::{Borrow, BorrowMut};
use std::collections::HashMap;
use std::fs::File;
use std::io::{BufRead, BufReader};

use super::const_map::get_symbols;

pub fn assemble(reader: BufReader<File>, out_file: File) {
    let mut exec_syms = get_symbols();
    let mut cur_mem_pos: usize = 15;

    for (index, r_line) in reader.lines().enumerate() {
        match r_line {
            Ok(line) => process_line(
                line,
                index,
                cur_mem_pos.borrow_mut(),
                exec_syms.borrow_mut(),
            ),
            Err(_) => println!("err"),
        }
    }
}

fn process_line(
    line: String,
    index: usize,
    cur_mem_pos: &mut usize,
    exec_syms: &'static mut HashMap<&str, usize>,
) {
    match format_instruction(line) {
        Some(formatted) => {
            selector(formatted, index, cur_mem_pos, exec_syms.borrow_mut());
        }
        None => {}
    }
}

fn format_instruction(line: String) -> Option<String> {
    let line = line.trim();

    if line.starts_with("//") || line == "" {
        return None;
    } else if line.contains("//") {
        let split_line = line.split("//").collect::<Vec<_>>();
        return Some(split_line[0].trim().to_string());
    }

    return Some(line.to_string());
}

fn selector(
    line: String,
    index: usize,
    cur_mem_pos: &mut usize,
    exec_syms: &'static mut HashMap<&str, usize>,
) -> String {
    if line.starts_with("@") || line.starts_with("(") {
        return parse_a_instruction(line, index, cur_mem_pos, exec_syms.borrow_mut());
    } else if line.contains("=") {
        return parse_c_instruction(line);
    } else if line.contains(";") {
        return parse_jmp_instruction(line);
    } else {
        return String::new();
    };
}

fn parse_a_instruction(
    line: String,
    index: usize,
    cur_mem_pos: &mut usize,
    exec_syms: &mut HashMap<&'static str, usize>,
) -> String {
    if line.starts_with("@") {
        let pos: usize;

        match exec_syms.get(line.replace("@", "").as_str()) {
            Some(mem_pos) => pos = mem_pos.clone(),
            None => {
                exec_syms.insert(&line, index);
                pos = index;
            }
        }

        return format!("{}{:b}", "0".repeat(16 - format!("{:b}", pos).len()), &pos);
    } else if line.starts_with("(") {
        let pos: usize;

        match exec_syms.get(line.replace("(", "").replace(")", "").as_str()) {
            Some(mem_pos) => pos = mem_pos.clone(),
            None => {
                exec_syms.insert(&line, *cur_mem_pos);
                pos = *cur_mem_pos;
            }
        }

        return format!("{}{:b}", "0".repeat(16 - format!("{:b}", pos).len()), &pos);
    } else {
        return String::new();
    }
}

fn parse_c_instruction(line: String) -> String {
    return String::new();
}

fn parse_jmp_instruction(line: String) -> String {
    return String::new();
}

fn parse_label(line: String, index: usize, exec_syms: &mut HashMap<&str, usize>) -> String {
    return String::new();
}
