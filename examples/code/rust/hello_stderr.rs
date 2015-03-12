#![feature(old_io)]
#![allow(unused_must_use)]

fn main() {
    writeln!(&mut std::old_io::stdio::stderr(), "Hello stderr");
}
