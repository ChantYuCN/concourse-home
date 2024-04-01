# Prometheus

Collect data based on Metrics.  

## Type of Metrics:  

- Counter

  Used when we want to record a value that only goes up  

```console
#Request count.
#Tasks completed.
#Error count.

# HELP promhttp_metric_handler_requests_total Total number of scrapes by HTTP status code.
# TYPE promhttp_metric_handler_requests_total counter
promhttp_metric_handler_requests_total{code="200"} 3997
promhttp_metric_handler_requests_total{code="500"} 0
promhttp_metric_handler_requests_total{code="503"} 0
```

- Gauge

  Used when we want to record a value that can go up or down  

```console
#Memory usage.
#Queue size.
#Number of requests in progress.

# HELP prometheus_tsdb_symbol_table_size_bytes Size of symbol table in memory for loaded blocks
# TYPE prometheus_tsdb_symbol_table_size_bytes gauge
prometheus_tsdb_symbol_table_size_bytes 816
```

- Histogram

Used when we want to record a distribution of values across ranges (aka buckets)  

```console
#Request/Response count with a duration between X and Y seconds.

# HELP prometheus_http_request_duration_seconds Histogram of latencies for HTTP requests.
# TYPE prometheus_http_request_duration_seconds histogram
prometheus_http_request_duration_seconds_bucket{handler="/",le="0.1"} 4
prometheus_http_request_duration_seconds_bucket{handler="/",le="0.2"} 4
prometheus_http_request_duration_seconds_bucket{handler="/",le="0.4"} 4
```

- Summary  

Used when we want to record a distribution of values across percentiles (aka quantiles)  

```console
#Request percentage with a duration of X seconds.
#Response percentage with a size of X bytes.

# HELP go_gc_duration_seconds A summary of the pause duration of garbage collection cycles.
# TYPE go_gc_duration_seconds summary
go_gc_duration_seconds{quantile="0"} 5.4603e-05
go_gc_duration_seconds{quantile="0.25"} 6.5151e-05

```

## Data Model

- metric name: Uniquely identified in series

- metric label: k-v pair

- notation: <metric name>{<label name>=<label value>, ...}, api_http_requests_total{method="POST", handler="/messages"}

- sample: Samples form the actual time series data (fload64 value, milisecs timestamp)

HA prometheus.  

 Identical alerts will be deduplicated by the Alertmanager.  

Scale prometheus.   

https://www.robustperception.io/scaling-and-federating-prometheus/  

monitor  
 -batch-jobs: Pushgateway  
 -network-device:  SNMP Exporter  
 -matchines: Node Exporter  
