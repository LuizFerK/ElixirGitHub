<br />

<p align="center">
  <img alt="Logo" src="./.github/logo.png" width="180px" />
</p>

<h1 align="center" style="text-align: center;">Repositoriex</h1>

<p align="center">
	<a href="https://github.com/LuizFerK">
		<img alt="Author" src="https://img.shields.io/badge/author-Luiz%20Fernando-6F63E8?style=flat" />
	</a>
	<a href="#">
		<img alt="Languages" src="https://img.shields.io/github/languages/count/LuizFerK/Repositoriex?color=6F63E8&style=flat" />
	</a>
	<a href="hhttps://github.com/LuizFerK/Repositoriex/stargazers">
		<img alt="Stars" src="https://img.shields.io/github/stars/LuizFerK/Repositoriex?color=6F63E8&style=flat" />
	</a>
	<a href="https://github.com/LuizFerK/Repositoriex/network/members">
		<img alt="Forks" src="https://img.shields.io/github/forks/LuizFerK/Repositoriex?color=6F63E8&style=flat" />
	</a>
	<a href="https://github.com/LuizFerK/Repositoriex/graphs/contributors">
		<img alt="Contributors" src="https://img.shields.io/github/contributors/LuizFerK/Repositoriex?color=6F63E8&style=flat" />
	</a>
  <a href="https://codecov.io/gh/LuizFerK/Repositoriex">
  <img src="https://codecov.io/gh/LuizFerK/Repositoriex/branch/main/graph/badge.svg?token=8XFXDOIH5R"/>
</a>
</p>

<p align="center">
	<b>Search the bests GitHub repositories securely and faster!</b><br />
	<span>Created with Elixir and Phoenix.</span><br />
	<sub>Made with ❤️</sub>
</p>

<br />

# :pushpin: Contents

- [Features](#rocket-features)
- [Installation](#wrench-installation)
- [Getting started](#bulb-getting-started)
- [Endpoints](#triangular_flag_on_post-endpoints)
- [Techs](#fire-techs)
- [Issues](#bug-issues)
- [License](#book-license)

# :rocket: Features

- Create, delete, and updates users
- Sign-in with JWT authentication
- Refresh authentication on each request
- Get all the repositories from a GitHub user

# :wrench: Installation

### Required :warning:
- Elixir
- Erlang
- Phoenix
- Postgres database

### SSH

SSH URLs provide access to a Git repository via SSH, a secure protocol. If you have an SSH key registered in your GitHub account, clone the project using this command:

```git clone git@github.com:LuizFerK/Repositoriex.git```

### HTTPS

In case you don't have an SSH key on your GitHub account, you can clone the project using the HTTPS URL, run this command:

```git clone https://github.com/LuizFerK/Repositoriex.git```

**Both of these commands will generate a folder called Repositoriex, with all the project**

# :bulb: Getting started

1. Run ```mix deps.get``` to install the dependencies
2. Create a postgres database named ```repositoriex```
3. On the ```config/dev.exs``` and ```config/test.exs``` files, change your postgres **user** and **password**
4. Run ```mix ecto.migrate``` to run the migrations to your database
5. Run ```mix phx.server``` to start the server on port 4000

# :triangular_flag_on_post: Endpoints

> All the endpoints except for the user's creation and sign-in are protected with JWT authentication. You'll need to pass a valid token from an existent user in every route as a Bearer Token authentication. You can get the token by signing in to the app on the users sign in route or, if you already are authenticated, you'll receive a new refreshed token for each request on the api

> If you use Insomnia as your HTTP API requester, you can use the [Insomnia Repositoriex Collection](https://github.com/LuizFerK/Repositoriex/blob/main/.github/insomnia.json) to set up your requests as fast as possible!

### Users

* :green_circle: Create - POST `http://localhost:4000/api/users`

	* Request
	
		```json
		{
		  "password": "123456"
		}
		```
	* Response - 201 Created
	
		```json
		{
		  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpX...",
		  "user": {
		    "id": "3f872fba-e185-4367-af7d-59bab458cf84"
		  }
		}
		```
* :red_circle: Delete - DELETE `http://localhost:4000/api/users/<user_id>` Response - 204 No Content

* :yellow_circle: Update - PUT `http://localhost:4000/api/users/<user_id>`

	* Request:
	
		```json
		{
		  "password": "123456"
		}
		```
	* Response - 200 Ok
	
		```json
		{
		  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpX...",
		  "user": {
		    "id": "3f872fba-e185-4367-af7d-59bab458cf84"
		  }
		}
		```

* :white_circle: Sign In - POST `http://localhost:4000/api/users/signin`

	* Request:
	
		```json
		{
		  "id": "3f872fba-e185-4367-af7d-59bab458cf84",
		  "password": "12345678"
		}
		```
	* Response - 200 Ok
	
		```json
		{
		  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpX..."
		}
		```

### Repositories

* :purple_circle: Get Repositories - GET `http://localhost:4000/api/repos/<github_username>`

	* Response - 200 Ok
	
		```json
		{
		  "repos": [
		    {
		      "id": 257664665,
		      "name": "GitHubExplorer",
		      "description": "A clean way to find your favorites repositories on GitHub!",
		      "html_url": "https://github.com/LuizFerK/GitHubExplorer",
		      "stargazers_count": 0
		    },
		    {
		      "id": 258383445,
		      "name": "GoBarber",
		      "description": "Create an appointment with your favorite barber in one click!",
		      "html_url": "https://github.com/LuizFerK/GoBarber",
		      "stargazers_count": 0
		    },
		    {
		      "id": 267723241,
		      "name": "GoFinances",
		      "description": "Help yourself to control your daily transactions and save money!",
		      "html_url": "https://github.com/LuizFerK/GoFinances",
		      "stargazers_count": 0
		    }
		  ],
		  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpX..."
		}
		```

# :fire: Techs

### Elixir (language)

### Phoenix (web framework)
- Ecto
- Guardian (authentication)
- PBKDF2 (password cryptography)
- Tesla (http client to external apis)

# :bug: Issues

Find a bug or error on the project? Please, feel free to send me the issue on the [Repositoriex issues area](https://github.com/LuizFerK/Repositoriex/issues), with a title and a description of your found!

If you know the origin of the error and know how to resolve it, please, send me a pull request, I will love to review it!

# :book: License

Released in 2020.

This project is under the [MIT license](https://github.com/LuizFerK/Repositoriex/blob/main/LICENSE).

<p align="center">
	< keep coding /> :rocket: :heart:
</p>
