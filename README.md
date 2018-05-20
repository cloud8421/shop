# Shop

# Lightweight dependency injection

## Intro

The aim of this tutorial is to outline a basic approach for dependency injection that can be used to write easily testable, side-effect rich code.

The codebase we will be working on is written in Elixir, but techniques can be applied to other BEAM languages as well.

The project requires Elixir >= 1.6.0.

After cloning the repository, we can checkout the `starter` branch and run:

`mix do deps.get, compile`

A basic integration test is included, which can be run with `mix test`.

## Example application

The application represents the a shop api, divided into two main components: a simple `store` (which is responsible to create and manipulate products) and a `front` api which provides a few JSON endpoints.

## Features

- Create new products via the API
- Fetch and filter products
- Fetch a report about products' general properties
