# Migrator

A sample phoenix application that conforms to Kubernetes liveness and readiness semantics.

**Note:** This is still an experiment, it has not been used in a production service yet.

## Purpose

The purpose of this experiment is to ensure your phoenix application is not restarted or killed by Kubernetes unless something is wrong,
only gets traffic when ready for it, and to be a good Kubernetes citizen.

To accomplish this the application has a tailored startup sequence of its supervisor tree.

## Start up sequence

#### 1. Repo
This is the DB connection etc, same as in a default phoenix setup.

#### 2. Liveness endpoint

Exposed on port 4001, and uses the LivenessRouter. This is what you should use in your kubernetes config for the livenessProbe. Since this endpoint
is up almost immediately Kubernetes will now recognize your app as alive and will not restart it. However we are not ready to accept traffic yet.

#### 3. DynamicEndpoint

A DynamicSupervisor responsible for starting the rest of the normal endpoints.

#### 4. MigrateWorker

This is a simple worker process that will run all ecto migrations, and when done request the DynamicEndpoint to start the rest of the endpoints.
The main purpose of the worker is to make sure that migrations have been run before we start accepting traffic.

#### 5. Endpoint

All your app's normal endpoints, including a readiness endpoint (uses port 4000). This is what the readinessProbe should use.
Once the readiness endpoint is up Kubernetes will start directing traffic to our application.

## Running

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Install Node.js dependencies with `cd assets && npm install`
* Start Phoenix endpoint with `mix phx.server` (or `iex -S mix phx.server`)

Liveness endpoint: `localhost:4001/_liveness`
Readiness endpoint (up after migrations): `localhost:4000/_readiness`
