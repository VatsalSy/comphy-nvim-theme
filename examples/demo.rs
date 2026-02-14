//! Rust Demo - CoMPhy Gruvbox Theme
//! Demonstrates Rust syntax highlighting features

use std::collections::HashMap;
use std::error::Error;
use std::fmt::{self, Display};

/// Constants
const MAX_BUFFER_SIZE: usize = 1024 * 1024;
const API_VERSION: &str = "2.0.0";

/// Custom error type
#[derive(Debug, Clone)]
pub enum AppError {
    NotFound(String),
    InvalidInput { field: String, value: String },
    DatabaseError(String),
}

impl Display for AppError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            AppError::NotFound(item) => write!(f, "Not found: {}", item),
            AppError::InvalidInput { field, value } => {
                write!(f, "Invalid input for {}: {}", field, value)
            }
            AppError::DatabaseError(msg) => write!(f, "Database error: {}", msg),
        }
    }
}

impl Error for AppError {}

/// Generic trait with associated types
pub trait Repository<T> {
    type Error;
    fn find_by_id(&self, id: u64) -> Result<Option<T>, Self::Error>;
    fn save(&mut self, entity: &T) -> Result<u64, Self::Error>;
}

/// Struct with derive macros
#[derive(Debug, Clone)]
pub struct User {
    pub id: u64,
    pub username: String,
    pub email: String,
    pub active: bool,
}

impl User {
    /// Creates a new user
    pub fn new(username: String, email: String) -> Self {
        Self {
            id: 0,
            username,
            email,
            active: true,
        }
    }

    /// Validates user data
    pub fn validate(&self) -> Result<(), AppError> {
        if self.username.is_empty() {
            return Err(AppError::InvalidInput {
                field: "username".to_string(),
                value: self.username.clone(),
            });
        }
        Ok(())
    }
}

/// Enum with different variants
#[derive(Debug, Clone, Copy)]
pub enum Status {
    Pending,
    Processing { progress: f32 },
    Completed,
    Failed { error_code: u32 },
}

/// Pattern matching examples
pub fn process_status(status: Status) -> String {
    match status {
        Status::Pending => "Waiting to start".to_string(),
        Status::Processing { progress } => format!("Processing: {:.1}%", progress * 100.0),
        Status::Completed => "Done".to_string(),
        Status::Failed { error_code } => format!("Failed with code {}", error_code),
    }
}

/// Closure and iterator examples
pub fn process_numbers(numbers: Vec<i32>) -> Vec<i32> {
    numbers
        .into_iter()
        .filter(|&n| n > 0)
        .map(|n| n * 2)
        .collect()
}

/// Main function
fn main() -> Result<(), Box<dyn Error>> {
    let user = User::new("alice".to_string(), "alice@example.com".to_string());
    user.validate()?;
    println!("Created user: {:?}", user);
    Ok(())
}
