use arboard::Clipboard;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let current_directory = std::env::current_dir().unwrap();
    println!(
        "Current directory: {:?} is now on your clipboard.",
        current_directory
    );
    let current_directory = current_directory.to_str().unwrap();

    let mut clipboard = Clipboard::new()?;
    let _ = clipboard.set_text(current_directory.to_owned());
    Ok(())
}
