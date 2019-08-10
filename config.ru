require "./config/env"


use Rack::MethodOverride
use UserController
use RoutineController
run ApplicationController