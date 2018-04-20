require './config/environment'



use Rack::MethodOverride

use PlayerController
use TeamController
use UserController
run ApplicationController
