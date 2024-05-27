FROM ruby:3.2.2-slim

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    libpq-dev \
    build-essential \
    libcurl4-openssl-dev \
    curl \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN npm install --global yarn

# Set the working directory
WORKDIR /docker/app

# Copy the essential files
COPY Gemfile Gemfile.lock Rakefile *.js package.json yarn.lock config.ru .ruby-version ./

# List the contents of the directory for debugging
RUN ls -lha

# Copy application folders
COPY app/ app/
COPY bin/ bin/
COPY config/ config/
COPY db/ db/
COPY lib/ lib/
COPY public/ public/
COPY storage/ storage/
COPY spec/ spec/

# Install Ruby gems
RUN bundle install

# Install JavaScript dependencies
RUN yarn install

# Copy the remaining application files
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
