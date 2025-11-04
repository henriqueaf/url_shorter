# URL Shorter

A Ruby on Rails API service for shortening URLs, similar to bit.ly or tinyurl.com. This application provides a RESTful API to create short URLs from long ones and redirect users to the original URLs.

## Table of Contents

- [Purpose](#purpose)
- [Features](#features)
- [API Endpoints](#api-endpoints)
- [Technology Stack](#technology-stack)
- [Getting Started with Docker Compose](#getting-started-with-docker-compose)
- [Usage Example](#usage-example)
- [Development](#development)
- [License](#license)

## Purpose

This URL shortener service allows you to:

- **Shorten URLs**: Convert long URLs into short, manageable links
- **Redirect**: Automatically redirect users from short URLs to their original destinations
- **API-based**: Provides a clean RESTful API for integration with other applications
- **Scalable**: Built with Redis for counter management and PostgreSQL for data persistence

## Features

- RESTful API endpoints for URL shortening
- Automatic short code generation using Hashids
- Redis-based counter for unique short code generation
- PostgreSQL database for reliable data storage
- Docker containerization for easy deployment
- Health check endpoint for monitoring

## API Endpoints

### Create Short URL
```
POST /api/v1/urls
Content-Type: application/json

{
  "url": "https://www.example.com/very/long/url/path"
}
```

**Response:**
```json
{
  "short_url": "http://localhost:3000/abc123"
}
```

### Redirect to Original URL
```
GET /:short_code
```

Redirects to the original URL associated with the short code.

### Health Check
```
GET /up
```

Returns the application health status.

## Technology Stack

- **Ruby on Rails** - Web framework
- **PostgreSQL** - Primary database
- **Redis** - Counter management and caching
- **Hashids** - Short code generation
- **Docker** - Containerization
- **Puma** - Application server

## Getting Started with Docker Compose

### Prerequisites

- Docker
- Docker Compose

### Installation and Setup

1. **Clone the repository:**
   ```bash
   git clone git@github.com:henriqueaf/url_shorter.git
   cd url_shorter
   ```

2. **Create environment file:**
   ```bash
   cp .env.example .env
   ```

   Edit the `.env` file with your configuration values if needed. But you can leave as it is in .env.example, it will work for development environment.

3. **Build and start the services:**
   ```bash
   docker-compose up --build
   ```

   This command will:
   - Build the Rails application image
   - Start PostgreSQL database container
   - Start Redis container
   - Start the Rails application container
   - Set up database and run migrations

4. **Access the application:**
   - API will be available at: `http://localhost:3000`
   - Health check: `http://localhost:3000/up`

### Development Commands

#### Start services in detached mode:
```bash
docker-compose up -d
```

**View logs:**
```bash
docker-compose logs -f app
```

**Stop services:**
```bash
docker-compose down
```

**Rebuild and restart:**
```bash
docker-compose down && docker-compose up --build
```

**Run Rails commands:**
```bash
# Open Rails console
docker-compose exec app rails console

# Run migrations
docker-compose exec app rails db:migrate

# Run tests
docker-compose exec app rails test

# Generate new migration
docker-compose exec app rails generate migration MigrationName
```

### Docker Services

The application consists of three main services:

- **app**: Rails application server (Port 3000)
- **db**: PostgreSQL database (Internal)
- **redis**: Redis server for caching and counters (Internal)

### Database Setup

The database will be automatically set up when you first run `docker-compose up`. If you need to reset the database:

```bash
docker-compose exec app rails db:drop db:create db:migrate db:seed
```

## Usage Example
Make sure the server is running: [start the server](#start-services-in-detached-mode)
1. **Create a short URL:**
   ```bash
   curl -X POST http://localhost:3000/api/v1/urls \
     -H "Content-Type: application/json" \
     -d '{"url": "https://www.google.com"}'
   ```

2. **Use the returned short URL:**
   Visit the returned short URL in your browser or use curl:
   ```bash
   curl -L http://localhost:3000/abc123
   ```

## Development

The application uses a modular structure with:

- **Models**: URL model with validation and short code generation
- **Controllers**: API controllers for URL operations
- **Services**: URL shortcode generation service using Redis counters
- **Tests**: Comprehensive test suite for all components

## License

This project is available as open source under the terms of the [MIT License](LICENSE).
