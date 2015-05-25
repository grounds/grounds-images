#![allow(unused_must_use)]

use std::io;
use std::io::prelude::*;

fn main() {
    writeln!(io::stderr(), "Hello stderr");
}