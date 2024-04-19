# Container Runtime Interface

The Kubernetes Container Runtime Interface (CRI) defines the **gRPC protocol** for the communication between kubelet and container runtime.  


# Interface

## RuntimeService  

RS defines the APIs for container runtime. Action: sandbox, containers, exec(SPDY).    

## ImageService  

IS defines the APIs for managing images. Action: Pull, List images.   

