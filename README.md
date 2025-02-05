# UVM-Jumpstart
### This repo gives a quick practical introduction to UVM. It is stressing the UART receiver side, and it gives a basic implementation of the UVM infrastructure. It works with Microchip's Modelsim free version. There is no need to have compiled UVM libraries. Design,simulation, and UVM libraries are compiled through ".do" file located under "run" folder. All the work has been realized in Ubuntu operating system.

![image info](./docs/uvm.svg)

### **Note:** There are two different RTL design files. The PurdNyUart requires manipulations in order to pass the compilation steps. Also, the baud rate configuration seems to be missing for PurdNyUart repo. Therefore, expected results and actual results do not match for this repo. Once it is understood how the baud rate is inserted into to UartRx.sv file, the comparison will be as expected.

### Comply with the below steps to checkout repo and submodules

```
- % git clone https://github.com/Purdue-SoCET/UVM-Jumpstart.git
- % git submodule init
- % git sumbodule update
```

### RTL Manipulation steps for ./PurdNyUart/UartRx/UartRx.sv file

```verilog
- output done should be output logic done. (line 11)
- output err should be output logic err. (line 12)
- logic [3:0] readCount, logic [sampleWidth-1:0] sampleCount, and logic edgeCmp signals should be moved under 47th line. 
```

### Once you've applied above steps. The RTL files can be compiled
# Please follow the steps below to complie design and verification files

```
- Make sure you are in UVM-Jumpstart folder.
- Once you are in UVM-Jumpstart folder, go to run folder. (cd run)
- Run the binary file of Modelsim.
- After Modelsim is opened, run the "do run.do" command in Modelsim console.
- Waveform will be automatically opened up.
```
