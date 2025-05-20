# SharpTPU

你的TPU怎么尖尖的 ?

第九届全国大学生集成电路创新创业大赛（集创赛）：多精度张量计算单元设计
http://univ.ciciec.com/nd.jsp?id=886

## 文件结构

├── Readme.md
├── .gitignore
├── funcModel/ 行为模型
├── floatMul/ 融合矩阵乘加单元
├── HDL/ 张量处理处理单元
│   ├── build.sh
│   ├── hw/ SpinalHDL代码
│   ├── testBench/ Cocotb测试文件

## 环境配置

- SpinalHDL 环境配置 [https://spinalhdl.github.io/SpinalDoc-RTD/zh_CN/master/SpinalHDL/Getting%20Started/Install%20and%20setup.html](https://spinalhdl.github.io/SpinalDoc-RTD/zh_CN/master/SpinalHDL/Getting%20Started/Install%20and%20setup.html)
- CocoTB 仿真环境配置[https://docs.cocotb.org/en/stable/quickstart.html](https://docs.cocotb.org/en/stable/quickstart.html)
- Icarus Verilog 和 Verilator 环境配置

## 如何运行

- 配置好相应的SpinalHDL、CocoTB、IVerilog、Verilator环境
- 打开 `./HDL/hw/spinal/sharpTPU/sharpTPUTop.scala`, 在 `./HDL/gen/`产生相应的Verilog代码
- 打开 `./HDL/testbench`

```bash
make
```
