use clipboard::ClipboardProvider;
use clipboard::ClipboardContext;

fn main() {
    let current_directory = std::env::current_dir().unwrap();
    println!("Current directory: {:?} is now on your clipboard.", current_directory);
    let current_directory = current_directory.to_str().unwrap();
    let mut ctx: ClipboardContext = ClipboardProvider::new().unwrap();
    ctx.set_contents(current_directory.to_owned()).unwrap();
}

