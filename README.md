# UVM-Jumpstart
 This repo gives a quick practical introduction to UVM. It is stressing the UART transmitter & receiver side, and it gives a basic implementation of the UVM infrastructure. It works with Microchip's Modelsim free version. There is no need to have compiled UVM libraries. Design,simulation, and UVM libraries are compiled through ".do" file located under "run" folder. All the work has been realized in Ubuntu operating system.

![image info](./docs/uvm.svg)

### Comply with the below steps to checkout repo and submodules

```
 git clone https://github.com/Purdue-SoCET/UVM-Jumpstart.git
 git submodule init
 git submodule update
```
### After checking out the repo, please follow the steps below to complie design and verification files

```
 cd UVM-Jumpstart/run
 vsim -c -do run.do
```
