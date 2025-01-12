Keycloak Authentication Example with Rails 7
This project is an example of integrating Keycloak v25 with a Ruby on Rails 7 application to handle login, logout, and registration functionality. It demonstrates how to configure Keycloak as an external identity provider for user authentication and management.

Features
User login via Keycloak.
User logout with session termination in both Rails and Keycloak.
User registration handled by Keycloak.
Secure integration using OAuth 2.0 and OpenID Connect (OIDC).
Example Keycloak configuration for client and realm setup.
Requirements
Ruby: >= 3.1
Rails: 7.x
Keycloak: v25.x
PostgreSQL (or any other Rails-supported database).
A Keycloak server properly installed and configured.
Setup Instructions
1. Clone the Repository
bash
Copiar código
git clone https://github.com/your-username/keycloak-rails-auth.git
cd keycloak-rails-auth
2. Install Dependencies
Install Ruby and JavaScript dependencies:

bash
Copiar código
bundle install
yarn install
3. Configure the Database
Set up your database credentials in config/database.yml. Then, create and migrate the database:

bash
Copiar código
rails db:create
rails db:migrate
4. Keycloak Configuration
Create a Realm:

Log in to the Keycloak admin console.
Create a new realm or use an existing one.
Create a Client:

Navigate to the "Clients" section under your realm.
Click "Create" and set the following values:
Client ID: rails-app
Client Protocol: openid-connect
Root URL: http://localhost:3000
Save the client, then update:

Set "Access Type" to confidential.
Enable "Service Accounts".
Configure valid redirect URIs (e.g., http://localhost:3000/*).
Add Roles (Optional):

Define custom roles if needed under "Roles" in your realm.
Download Client Credentials:

Under the "Credentials" tab for the client, note the Client ID and Client Secret.
5. Set Environment Variables
Create a .env file in the root directory and configure it with your Keycloak client details:

bash
Copiar código
KEYCLOAK_CLIENT_ID=rails-app
KEYCLOAK_CLIENT_SECRET=your-client-secret
KEYCLOAK_SERVER_URL=http://localhost:8080
KEYCLOAK_REALM=your-realm
REDIRECT_URI=http://localhost:3000/auth/callback
You can use the dotenv-rails gem to load these variables.

6. Update Rails Configuration
In config/initializers/keycloak.rb, configure the OIDC strategy:

ruby
Copiar código
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :keycloak_openid, ENV['KEYCLOAK_CLIENT_ID'], ENV['KEYCLOAK_CLIENT_SECRET'],
           client_options: {
             site: "#{ENV['KEYCLOAK_SERVER_URL']}/realms/#{ENV['KEYCLOAK_REALM']}",
             authorize_url: "/protocol/openid-connect/auth",
             token_url: "/protocol/openid-connect/token",
             userinfo_url: "/protocol/openid-connect/userinfo"
           }
end
7. Start the Application
Run the Rails server:

bash
Copiar código
rails server
Visit http://localhost:3000 to access the app.

Usage
Login
Click the "Login" button on the home page.
You will be redirected to the Keycloak login screen.
After successful login, you will be redirected back to the application.
Logout
Click the "Logout" button.
The session will be terminated both in Rails and Keycloak.
Registration
Use the "Register" option on the Keycloak login screen to create a new user.
Testing
Run the test suite:

bash
Copiar código
rails test
Troubleshooting
Invalid redirect URI: Ensure the URI in the Keycloak client matches the one used in your Rails app.
Missing credentials: Double-check your .env file and Keycloak client setup.
Session issues: Verify your session store settings in config/initializers/session_store.rb.
