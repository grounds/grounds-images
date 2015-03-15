#![feature(old_io)]
#![allow(unused_must_use)]
#![allow(deprecated)]
use std::old_io as io;

// Rust is currently unstable. The core team is
// working a lot on I/O module.
//
// Therefore this example may fail after rebuilding
// the rust image using lastest nightly.

fn main() {
    writeln!(&mut io::stderr(), "Hello stderr");
}
