require "./config/env"


use Rack::MethodOverride
use UserController
use RoutineController
use ProductController
run ApplicationController