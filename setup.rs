use colored::Colorize;
use directories::ProjectDirs;
use serde::{Deserialize, Serialize};
use std::fs;

pub enum SetupResult {
    Anonymous,
    Connected(String),
    Invalid,
}

#[derive(Serialize, Deserialize)]
pub struct UserConfig {
    pub node_id: String,
    pub user_id: Option<String>,
}

fn save_node_id(node_id: &str) -> std::io::Result<()> {
    let proj_dirs =
        ProjectDirs::from("xyz", "nexus", "cli").expect("Failed to determine config directory");
    let config_path = proj_dirs.config_dir().join("user.json");

    let config = UserConfig {
        node_id: node_id.to_string(),
        user_id: None,
    };

    fs::create_dir_all(proj_dirs.config_dir())?;
    fs::write(&config_path, serde_json::to_string_pretty(&config)?)?;

    println!("Node ID {} saved successfully!", node_id);
    Ok(())
}

pub async fn run_initial_setup() -> SetupResult {
    let proj_dirs =
        ProjectDirs::from("xyz", "nexus", "cli").expect("Failed to determine config directory");
    let config_path = proj_dirs.config_dir().join("user.json");

    // Cek apakah ada konfigurasi yang sudah tersimpan
    if config_path.exists() {
        println!("\nThis node is already connected to an account");

        match fs::read_to_string(&config_path) {
            Ok(content) => match serde_json::from_str::<UserConfig>(&content) {
                Ok(user_config) => {
                    println!("\nUsing existing node ID: {}", user_config.node_id);
                    return SetupResult::Connected(user_config.node_id);
                }
                Err(e) => {
                    println!("{}", format!("Failed to parse config file: {}", e).red());
                    return SetupResult::Invalid;
                }
            },
            Err(e) => {
                println!("{}", format!("Failed to read config file: {}", e).red());
                return SetupResult::Invalid;
            }
        }
    }

    // Gunakan node_id yang sudah ditentukan tanpa meminta input pengguna
    let node_id = "NODE_ID_MU".to_string();
    println!("Using predefined node ID: {}", node_id);

    match save_node_id(&node_id) {
        Ok(_) => SetupResult::Connected(node_id),
        Err(e) => {
            println!("{}", format!("Failed to save node ID: {}", e).red());
            SetupResult::Invalid
        }
    }
}

pub fn clear_user_config() -> std::io::Result<()> {
    let proj_dirs =
        ProjectDirs::from("xyz", "nexus", "cli").expect("Failed to determine config directory");
    let config_path = proj_dirs.config_dir().join("user.json");
    
    if config_path.exists() {
        fs::remove_file(config_path)?;
        println!("User configuration cleared successfully!");
    }

    Ok(())
}