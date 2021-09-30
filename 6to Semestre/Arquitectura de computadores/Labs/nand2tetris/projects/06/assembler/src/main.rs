pub mod asm;

use std::env;
use std::fs::File;
use std::io::BufReader;

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = &args[1];
    let reader: BufReader<File>;

    match File::open(path) {
        Ok(file) => reader = BufReader::new(file),
        Err(_) => {
            println!("Error! File not found.");
            return;
        }
    }

    let mut out_file: File = match File::create(path.replace(".asm", ".hack")) {
        Ok(out_file) => out_file,
        Err(_) => {
            println!("Error! File not found.");
            return;
        }
    };

    asm::assembler::assemble(reader, out_file);
}
