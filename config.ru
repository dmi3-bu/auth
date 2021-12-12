require './config/environment'

use Rack::RequestId
use Rack::Runtime
use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter
use Rack::Ougai::LogRequests, Application.logger

run Application
