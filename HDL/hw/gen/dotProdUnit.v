// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : dotProdUnit
// Git hash  : 6cfd76b84f305cdf0f2b3f3bc40f249c97c5cd9c

`timescale 1ns/1ps

module dotProdUnit (
  input  wire [2:0]    io_op,
  input  wire [511:0]  io_vecA,
  input  wire [511:0]  io_vecB,
  input  wire [127:0]  io_vecC,
  output wire [127:0]  io_vecD,
  output wire [1:0]    io_nan_f,
  output wire [1:0]    io_inf_f,
  output wire [3:0]    io_ovf_i,
  input  wire          clk,
  input  wire          resetn
);
  localparam ArithOp_FP32 = 3'd1;
  localparam ArithOp_FP16 = 3'd2;
  localparam ArithOp_FP16_MIX = 3'd3;
  localparam ArithOp_INT8 = 3'd4;
  localparam ArithOp_INT4 = 3'd5;
  localparam PackOp_INTx = 2'd0;
  localparam PackOp_FP32 = 2'd1;
  localparam PackOp_FP16 = 2'd2;
  localparam FpFlag_ZERO = 2'd0;
  localparam FpFlag_NORM = 2'd1;
  localparam FpFlag_INF = 2'd2;
  localparam FpFlag_NAN = 2'd3;

  wire                alignerFP_P_0_0_io_i_sel;
  wire       [47:0]   alignerFP_P_0_0_io_i_mtsa;
  wire                alignerFP_P_0_1_io_i_sel;
  wire       [47:0]   alignerFP_P_0_1_io_i_mtsa;
  wire                alignerFP_P_0_2_io_i_sel;
  wire       [47:0]   alignerFP_P_0_2_io_i_mtsa;
  wire                alignerFP_P_0_3_io_i_sel;
  wire       [47:0]   alignerFP_P_0_3_io_i_mtsa;
  wire                alignerFP_P_0_4_io_i_sel;
  wire       [47:0]   alignerFP_P_0_4_io_i_mtsa;
  wire                alignerFP_P_0_5_io_i_sel;
  wire       [47:0]   alignerFP_P_0_5_io_i_mtsa;
  wire                alignerFP_P_0_6_io_i_sel;
  wire       [47:0]   alignerFP_P_0_6_io_i_mtsa;
  wire                alignerFP_P_0_7_io_i_sel;
  wire       [47:0]   alignerFP_P_0_7_io_i_mtsa;
  wire                alignerFP_P_0_8_io_i_sel;
  wire       [47:0]   alignerFP_P_0_8_io_i_mtsa;
  wire                alignerFP_P_0_9_io_i_sel;
  wire       [47:0]   alignerFP_P_0_9_io_i_mtsa;
  wire                alignerFP_P_0_10_io_i_sel;
  wire       [47:0]   alignerFP_P_0_10_io_i_mtsa;
  wire                alignerFP_P_0_11_io_i_sel;
  wire       [47:0]   alignerFP_P_0_11_io_i_mtsa;
  wire                alignerFP_P_0_12_io_i_sel;
  wire       [47:0]   alignerFP_P_0_12_io_i_mtsa;
  wire                alignerFP_P_0_13_io_i_sel;
  wire       [47:0]   alignerFP_P_0_13_io_i_mtsa;
  wire                alignerFP_P_0_14_io_i_sel;
  wire       [47:0]   alignerFP_P_0_14_io_i_mtsa;
  wire                alignerFP_P_0_15_io_i_sel;
  wire       [47:0]   alignerFP_P_0_15_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_0_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_1_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_2_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_3_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_4_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_5_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_6_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_7_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_8_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_9_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_10_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_11_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_12_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_13_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_14_io_i_mtsa;
  wire       [47:0]   alignerFP_P_1_15_io_i_mtsa;
  wire                alignerFP_C_0_io_i_sel;
  wire                alignerFP_C_1_io_i_sel;
  wire       [55:0]   addTreeInst_0_io_i_data_0;
  wire       [55:0]   addTreeInst_0_io_i_data_1;
  wire       [55:0]   addTreeInst_0_io_i_data_2;
  wire       [55:0]   addTreeInst_0_io_i_data_3;
  wire       [55:0]   addTreeInst_0_io_i_data_4;
  wire       [55:0]   addTreeInst_0_io_i_data_5;
  wire       [55:0]   addTreeInst_0_io_i_data_6;
  wire       [55:0]   addTreeInst_0_io_i_data_7;
  wire       [55:0]   addTreeInst_0_io_i_data_8;
  wire       [55:0]   addTreeInst_0_io_i_data_9;
  wire       [55:0]   addTreeInst_0_io_i_data_10;
  wire       [55:0]   addTreeInst_0_io_i_data_11;
  wire       [55:0]   addTreeInst_0_io_i_data_12;
  wire       [55:0]   addTreeInst_0_io_i_data_13;
  wire       [55:0]   addTreeInst_0_io_i_data_14;
  wire       [55:0]   addTreeInst_0_io_i_data_15;
  wire       [55:0]   addTreeInst_0_io_i_data_16;
  wire       [55:0]   addTreeInst_1_io_i_data_0;
  wire       [55:0]   addTreeInst_1_io_i_data_1;
  wire       [55:0]   addTreeInst_1_io_i_data_2;
  wire       [55:0]   addTreeInst_1_io_i_data_3;
  wire       [55:0]   addTreeInst_1_io_i_data_4;
  wire       [55:0]   addTreeInst_1_io_i_data_5;
  wire       [55:0]   addTreeInst_1_io_i_data_6;
  wire       [55:0]   addTreeInst_1_io_i_data_7;
  wire       [55:0]   addTreeInst_1_io_i_data_8;
  wire       [55:0]   addTreeInst_1_io_i_data_9;
  wire       [55:0]   addTreeInst_1_io_i_data_10;
  wire       [55:0]   addTreeInst_1_io_i_data_11;
  wire       [55:0]   addTreeInst_1_io_i_data_12;
  wire       [55:0]   addTreeInst_1_io_i_data_13;
  wire       [55:0]   addTreeInst_1_io_i_data_14;
  wire       [55:0]   addTreeInst_1_io_i_data_15;
  wire       [55:0]   addTreeInst_1_io_i_data_16;
  wire                roundInst_0_io_i_sel;
  wire                roundInst_1_io_i_sel;
  wire       [21:0]   intAdder_0_io_i_Q;
  wire       [21:0]   intAdder_1_io_i_Q;
  wire       [21:0]   intAdder_2_io_i_Q;
  wire       [21:0]   intAdder_3_io_i_Q;
  wire       [63:0]   mulUnit_17_io_P_mtsa;
  wire       [9:0]    expnAddUnit_34_io_P_expn;
  wire                expnAddUnit_34_io_P_sign;
  wire       [1:0]    expnAddUnit_34_io_P_flag;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_0;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_1;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_2;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_3;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_4;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_5;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_6;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_7;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_8;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_9;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_10;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_11;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_12;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_13;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_14;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_15;
  wire       [9:0]    nrshUnit_3_io_P_nrsh_16;
  wire       [9:0]    nrshUnit_3_io_Q_expn;
  wire                nrshUnit_3_io_Q_sign;
  wire       [1:0]    nrshUnit_3_io_Q_flag;
  wire       [31:0]   unpackerA_0_io_mtsa;
  wire       [7:0]    unpackerA_0_io_expn_0;
  wire       [7:0]    unpackerA_0_io_expn_1;
  wire                unpackerA_0_io_sign_0;
  wire                unpackerA_0_io_sign_1;
  wire       [1:0]    unpackerA_0_io_flag_0;
  wire       [1:0]    unpackerA_0_io_flag_1;
  wire       [31:0]   unpackerA_1_io_mtsa;
  wire       [7:0]    unpackerA_1_io_expn_0;
  wire       [7:0]    unpackerA_1_io_expn_1;
  wire                unpackerA_1_io_sign_0;
  wire                unpackerA_1_io_sign_1;
  wire       [1:0]    unpackerA_1_io_flag_0;
  wire       [1:0]    unpackerA_1_io_flag_1;
  wire       [31:0]   unpackerA_2_io_mtsa;
  wire       [7:0]    unpackerA_2_io_expn_0;
  wire       [7:0]    unpackerA_2_io_expn_1;
  wire                unpackerA_2_io_sign_0;
  wire                unpackerA_2_io_sign_1;
  wire       [1:0]    unpackerA_2_io_flag_0;
  wire       [1:0]    unpackerA_2_io_flag_1;
  wire       [31:0]   unpackerA_3_io_mtsa;
  wire       [7:0]    unpackerA_3_io_expn_0;
  wire       [7:0]    unpackerA_3_io_expn_1;
  wire                unpackerA_3_io_sign_0;
  wire                unpackerA_3_io_sign_1;
  wire       [1:0]    unpackerA_3_io_flag_0;
  wire       [1:0]    unpackerA_3_io_flag_1;
  wire       [31:0]   unpackerA_4_io_mtsa;
  wire       [7:0]    unpackerA_4_io_expn_0;
  wire       [7:0]    unpackerA_4_io_expn_1;
  wire                unpackerA_4_io_sign_0;
  wire                unpackerA_4_io_sign_1;
  wire       [1:0]    unpackerA_4_io_flag_0;
  wire       [1:0]    unpackerA_4_io_flag_1;
  wire       [31:0]   unpackerA_5_io_mtsa;
  wire       [7:0]    unpackerA_5_io_expn_0;
  wire       [7:0]    unpackerA_5_io_expn_1;
  wire                unpackerA_5_io_sign_0;
  wire                unpackerA_5_io_sign_1;
  wire       [1:0]    unpackerA_5_io_flag_0;
  wire       [1:0]    unpackerA_5_io_flag_1;
  wire       [31:0]   unpackerA_6_io_mtsa;
  wire       [7:0]    unpackerA_6_io_expn_0;
  wire       [7:0]    unpackerA_6_io_expn_1;
  wire                unpackerA_6_io_sign_0;
  wire                unpackerA_6_io_sign_1;
  wire       [1:0]    unpackerA_6_io_flag_0;
  wire       [1:0]    unpackerA_6_io_flag_1;
  wire       [31:0]   unpackerA_7_io_mtsa;
  wire       [7:0]    unpackerA_7_io_expn_0;
  wire       [7:0]    unpackerA_7_io_expn_1;
  wire                unpackerA_7_io_sign_0;
  wire                unpackerA_7_io_sign_1;
  wire       [1:0]    unpackerA_7_io_flag_0;
  wire       [1:0]    unpackerA_7_io_flag_1;
  wire       [31:0]   unpackerA_8_io_mtsa;
  wire       [7:0]    unpackerA_8_io_expn_0;
  wire       [7:0]    unpackerA_8_io_expn_1;
  wire                unpackerA_8_io_sign_0;
  wire                unpackerA_8_io_sign_1;
  wire       [1:0]    unpackerA_8_io_flag_0;
  wire       [1:0]    unpackerA_8_io_flag_1;
  wire       [31:0]   unpackerA_9_io_mtsa;
  wire       [7:0]    unpackerA_9_io_expn_0;
  wire       [7:0]    unpackerA_9_io_expn_1;
  wire                unpackerA_9_io_sign_0;
  wire                unpackerA_9_io_sign_1;
  wire       [1:0]    unpackerA_9_io_flag_0;
  wire       [1:0]    unpackerA_9_io_flag_1;
  wire       [31:0]   unpackerA_10_io_mtsa;
  wire       [7:0]    unpackerA_10_io_expn_0;
  wire       [7:0]    unpackerA_10_io_expn_1;
  wire                unpackerA_10_io_sign_0;
  wire                unpackerA_10_io_sign_1;
  wire       [1:0]    unpackerA_10_io_flag_0;
  wire       [1:0]    unpackerA_10_io_flag_1;
  wire       [31:0]   unpackerA_11_io_mtsa;
  wire       [7:0]    unpackerA_11_io_expn_0;
  wire       [7:0]    unpackerA_11_io_expn_1;
  wire                unpackerA_11_io_sign_0;
  wire                unpackerA_11_io_sign_1;
  wire       [1:0]    unpackerA_11_io_flag_0;
  wire       [1:0]    unpackerA_11_io_flag_1;
  wire       [31:0]   unpackerA_12_io_mtsa;
  wire       [7:0]    unpackerA_12_io_expn_0;
  wire       [7:0]    unpackerA_12_io_expn_1;
  wire                unpackerA_12_io_sign_0;
  wire                unpackerA_12_io_sign_1;
  wire       [1:0]    unpackerA_12_io_flag_0;
  wire       [1:0]    unpackerA_12_io_flag_1;
  wire       [31:0]   unpackerA_13_io_mtsa;
  wire       [7:0]    unpackerA_13_io_expn_0;
  wire       [7:0]    unpackerA_13_io_expn_1;
  wire                unpackerA_13_io_sign_0;
  wire                unpackerA_13_io_sign_1;
  wire       [1:0]    unpackerA_13_io_flag_0;
  wire       [1:0]    unpackerA_13_io_flag_1;
  wire       [31:0]   unpackerA_14_io_mtsa;
  wire       [7:0]    unpackerA_14_io_expn_0;
  wire       [7:0]    unpackerA_14_io_expn_1;
  wire                unpackerA_14_io_sign_0;
  wire                unpackerA_14_io_sign_1;
  wire       [1:0]    unpackerA_14_io_flag_0;
  wire       [1:0]    unpackerA_14_io_flag_1;
  wire       [31:0]   unpackerA_15_io_mtsa;
  wire       [7:0]    unpackerA_15_io_expn_0;
  wire       [7:0]    unpackerA_15_io_expn_1;
  wire                unpackerA_15_io_sign_0;
  wire                unpackerA_15_io_sign_1;
  wire       [1:0]    unpackerA_15_io_flag_0;
  wire       [1:0]    unpackerA_15_io_flag_1;
  wire       [31:0]   unpackerB_0_io_mtsa;
  wire       [7:0]    unpackerB_0_io_expn_0;
  wire       [7:0]    unpackerB_0_io_expn_1;
  wire                unpackerB_0_io_sign_0;
  wire                unpackerB_0_io_sign_1;
  wire       [1:0]    unpackerB_0_io_flag_0;
  wire       [1:0]    unpackerB_0_io_flag_1;
  wire       [31:0]   unpackerB_1_io_mtsa;
  wire       [7:0]    unpackerB_1_io_expn_0;
  wire       [7:0]    unpackerB_1_io_expn_1;
  wire                unpackerB_1_io_sign_0;
  wire                unpackerB_1_io_sign_1;
  wire       [1:0]    unpackerB_1_io_flag_0;
  wire       [1:0]    unpackerB_1_io_flag_1;
  wire       [31:0]   unpackerB_2_io_mtsa;
  wire       [7:0]    unpackerB_2_io_expn_0;
  wire       [7:0]    unpackerB_2_io_expn_1;
  wire                unpackerB_2_io_sign_0;
  wire                unpackerB_2_io_sign_1;
  wire       [1:0]    unpackerB_2_io_flag_0;
  wire       [1:0]    unpackerB_2_io_flag_1;
  wire       [31:0]   unpackerB_3_io_mtsa;
  wire       [7:0]    unpackerB_3_io_expn_0;
  wire       [7:0]    unpackerB_3_io_expn_1;
  wire                unpackerB_3_io_sign_0;
  wire                unpackerB_3_io_sign_1;
  wire       [1:0]    unpackerB_3_io_flag_0;
  wire       [1:0]    unpackerB_3_io_flag_1;
  wire       [31:0]   unpackerB_4_io_mtsa;
  wire       [7:0]    unpackerB_4_io_expn_0;
  wire       [7:0]    unpackerB_4_io_expn_1;
  wire                unpackerB_4_io_sign_0;
  wire                unpackerB_4_io_sign_1;
  wire       [1:0]    unpackerB_4_io_flag_0;
  wire       [1:0]    unpackerB_4_io_flag_1;
  wire       [31:0]   unpackerB_5_io_mtsa;
  wire       [7:0]    unpackerB_5_io_expn_0;
  wire       [7:0]    unpackerB_5_io_expn_1;
  wire                unpackerB_5_io_sign_0;
  wire                unpackerB_5_io_sign_1;
  wire       [1:0]    unpackerB_5_io_flag_0;
  wire       [1:0]    unpackerB_5_io_flag_1;
  wire       [31:0]   unpackerB_6_io_mtsa;
  wire       [7:0]    unpackerB_6_io_expn_0;
  wire       [7:0]    unpackerB_6_io_expn_1;
  wire                unpackerB_6_io_sign_0;
  wire                unpackerB_6_io_sign_1;
  wire       [1:0]    unpackerB_6_io_flag_0;
  wire       [1:0]    unpackerB_6_io_flag_1;
  wire       [31:0]   unpackerB_7_io_mtsa;
  wire       [7:0]    unpackerB_7_io_expn_0;
  wire       [7:0]    unpackerB_7_io_expn_1;
  wire                unpackerB_7_io_sign_0;
  wire                unpackerB_7_io_sign_1;
  wire       [1:0]    unpackerB_7_io_flag_0;
  wire       [1:0]    unpackerB_7_io_flag_1;
  wire       [31:0]   unpackerB_8_io_mtsa;
  wire       [7:0]    unpackerB_8_io_expn_0;
  wire       [7:0]    unpackerB_8_io_expn_1;
  wire                unpackerB_8_io_sign_0;
  wire                unpackerB_8_io_sign_1;
  wire       [1:0]    unpackerB_8_io_flag_0;
  wire       [1:0]    unpackerB_8_io_flag_1;
  wire       [31:0]   unpackerB_9_io_mtsa;
  wire       [7:0]    unpackerB_9_io_expn_0;
  wire       [7:0]    unpackerB_9_io_expn_1;
  wire                unpackerB_9_io_sign_0;
  wire                unpackerB_9_io_sign_1;
  wire       [1:0]    unpackerB_9_io_flag_0;
  wire       [1:0]    unpackerB_9_io_flag_1;
  wire       [31:0]   unpackerB_10_io_mtsa;
  wire       [7:0]    unpackerB_10_io_expn_0;
  wire       [7:0]    unpackerB_10_io_expn_1;
  wire                unpackerB_10_io_sign_0;
  wire                unpackerB_10_io_sign_1;
  wire       [1:0]    unpackerB_10_io_flag_0;
  wire       [1:0]    unpackerB_10_io_flag_1;
  wire       [31:0]   unpackerB_11_io_mtsa;
  wire       [7:0]    unpackerB_11_io_expn_0;
  wire       [7:0]    unpackerB_11_io_expn_1;
  wire                unpackerB_11_io_sign_0;
  wire                unpackerB_11_io_sign_1;
  wire       [1:0]    unpackerB_11_io_flag_0;
  wire       [1:0]    unpackerB_11_io_flag_1;
  wire       [31:0]   unpackerB_12_io_mtsa;
  wire       [7:0]    unpackerB_12_io_expn_0;
  wire       [7:0]    unpackerB_12_io_expn_1;
  wire                unpackerB_12_io_sign_0;
  wire                unpackerB_12_io_sign_1;
  wire       [1:0]    unpackerB_12_io_flag_0;
  wire       [1:0]    unpackerB_12_io_flag_1;
  wire       [31:0]   unpackerB_13_io_mtsa;
  wire       [7:0]    unpackerB_13_io_expn_0;
  wire       [7:0]    unpackerB_13_io_expn_1;
  wire                unpackerB_13_io_sign_0;
  wire                unpackerB_13_io_sign_1;
  wire       [1:0]    unpackerB_13_io_flag_0;
  wire       [1:0]    unpackerB_13_io_flag_1;
  wire       [31:0]   unpackerB_14_io_mtsa;
  wire       [7:0]    unpackerB_14_io_expn_0;
  wire       [7:0]    unpackerB_14_io_expn_1;
  wire                unpackerB_14_io_sign_0;
  wire                unpackerB_14_io_sign_1;
  wire       [1:0]    unpackerB_14_io_flag_0;
  wire       [1:0]    unpackerB_14_io_flag_1;
  wire       [31:0]   unpackerB_15_io_mtsa;
  wire       [7:0]    unpackerB_15_io_expn_0;
  wire       [7:0]    unpackerB_15_io_expn_1;
  wire                unpackerB_15_io_sign_0;
  wire                unpackerB_15_io_sign_1;
  wire       [1:0]    unpackerB_15_io_flag_0;
  wire       [1:0]    unpackerB_15_io_flag_1;
  wire       [23:0]   pathCInst_io_c_mtsa_0;
  wire       [23:0]   pathCInst_io_c_mtsa_1;
  wire       [9:0]    pathCInst_io_c_expn_0;
  wire       [9:0]    pathCInst_io_c_expn_1;
  wire                pathCInst_io_c_sign_0;
  wire                pathCInst_io_c_sign_1;
  wire       [1:0]    pathCInst_io_c_flag_0;
  wire       [1:0]    pathCInst_io_c_flag_1;
  wire       [63:0]   mulAB_0_io_P_mtsa;
  wire       [63:0]   mulAB_1_io_P_mtsa;
  wire       [63:0]   mulAB_2_io_P_mtsa;
  wire       [63:0]   mulAB_3_io_P_mtsa;
  wire       [63:0]   mulAB_4_io_P_mtsa;
  wire       [63:0]   mulAB_5_io_P_mtsa;
  wire       [63:0]   mulAB_6_io_P_mtsa;
  wire       [63:0]   mulAB_7_io_P_mtsa;
  wire       [63:0]   mulAB_8_io_P_mtsa;
  wire       [63:0]   mulAB_9_io_P_mtsa;
  wire       [63:0]   mulAB_10_io_P_mtsa;
  wire       [63:0]   mulAB_11_io_P_mtsa;
  wire       [63:0]   mulAB_12_io_P_mtsa;
  wire       [63:0]   mulAB_13_io_P_mtsa;
  wire       [63:0]   mulAB_14_io_P_mtsa;
  wire       [63:0]   mulAB_15_io_P_mtsa;
  wire       [9:0]    expAB_0_0_io_P_expn;
  wire                expAB_0_0_io_P_sign;
  wire       [1:0]    expAB_0_0_io_P_flag;
  wire       [9:0]    expAB_0_1_io_P_expn;
  wire                expAB_0_1_io_P_sign;
  wire       [1:0]    expAB_0_1_io_P_flag;
  wire       [9:0]    expAB_0_2_io_P_expn;
  wire                expAB_0_2_io_P_sign;
  wire       [1:0]    expAB_0_2_io_P_flag;
  wire       [9:0]    expAB_0_3_io_P_expn;
  wire                expAB_0_3_io_P_sign;
  wire       [1:0]    expAB_0_3_io_P_flag;
  wire       [9:0]    expAB_0_4_io_P_expn;
  wire                expAB_0_4_io_P_sign;
  wire       [1:0]    expAB_0_4_io_P_flag;
  wire       [9:0]    expAB_0_5_io_P_expn;
  wire                expAB_0_5_io_P_sign;
  wire       [1:0]    expAB_0_5_io_P_flag;
  wire       [9:0]    expAB_0_6_io_P_expn;
  wire                expAB_0_6_io_P_sign;
  wire       [1:0]    expAB_0_6_io_P_flag;
  wire       [9:0]    expAB_0_7_io_P_expn;
  wire                expAB_0_7_io_P_sign;
  wire       [1:0]    expAB_0_7_io_P_flag;
  wire       [9:0]    expAB_0_8_io_P_expn;
  wire                expAB_0_8_io_P_sign;
  wire       [1:0]    expAB_0_8_io_P_flag;
  wire       [9:0]    expAB_0_9_io_P_expn;
  wire                expAB_0_9_io_P_sign;
  wire       [1:0]    expAB_0_9_io_P_flag;
  wire       [9:0]    expAB_0_10_io_P_expn;
  wire                expAB_0_10_io_P_sign;
  wire       [1:0]    expAB_0_10_io_P_flag;
  wire       [9:0]    expAB_0_11_io_P_expn;
  wire                expAB_0_11_io_P_sign;
  wire       [1:0]    expAB_0_11_io_P_flag;
  wire       [9:0]    expAB_0_12_io_P_expn;
  wire                expAB_0_12_io_P_sign;
  wire       [1:0]    expAB_0_12_io_P_flag;
  wire       [9:0]    expAB_0_13_io_P_expn;
  wire                expAB_0_13_io_P_sign;
  wire       [1:0]    expAB_0_13_io_P_flag;
  wire       [9:0]    expAB_0_14_io_P_expn;
  wire                expAB_0_14_io_P_sign;
  wire       [1:0]    expAB_0_14_io_P_flag;
  wire       [9:0]    expAB_0_15_io_P_expn;
  wire                expAB_0_15_io_P_sign;
  wire       [1:0]    expAB_0_15_io_P_flag;
  wire       [9:0]    expAB_1_0_io_P_expn;
  wire                expAB_1_0_io_P_sign;
  wire       [1:0]    expAB_1_0_io_P_flag;
  wire       [9:0]    expAB_1_1_io_P_expn;
  wire                expAB_1_1_io_P_sign;
  wire       [1:0]    expAB_1_1_io_P_flag;
  wire       [9:0]    expAB_1_2_io_P_expn;
  wire                expAB_1_2_io_P_sign;
  wire       [1:0]    expAB_1_2_io_P_flag;
  wire       [9:0]    expAB_1_3_io_P_expn;
  wire                expAB_1_3_io_P_sign;
  wire       [1:0]    expAB_1_3_io_P_flag;
  wire       [9:0]    expAB_1_4_io_P_expn;
  wire                expAB_1_4_io_P_sign;
  wire       [1:0]    expAB_1_4_io_P_flag;
  wire       [9:0]    expAB_1_5_io_P_expn;
  wire                expAB_1_5_io_P_sign;
  wire       [1:0]    expAB_1_5_io_P_flag;
  wire       [9:0]    expAB_1_6_io_P_expn;
  wire                expAB_1_6_io_P_sign;
  wire       [1:0]    expAB_1_6_io_P_flag;
  wire       [9:0]    expAB_1_7_io_P_expn;
  wire                expAB_1_7_io_P_sign;
  wire       [1:0]    expAB_1_7_io_P_flag;
  wire       [9:0]    expAB_1_8_io_P_expn;
  wire                expAB_1_8_io_P_sign;
  wire       [1:0]    expAB_1_8_io_P_flag;
  wire       [9:0]    expAB_1_9_io_P_expn;
  wire                expAB_1_9_io_P_sign;
  wire       [1:0]    expAB_1_9_io_P_flag;
  wire       [9:0]    expAB_1_10_io_P_expn;
  wire                expAB_1_10_io_P_sign;
  wire       [1:0]    expAB_1_10_io_P_flag;
  wire       [9:0]    expAB_1_11_io_P_expn;
  wire                expAB_1_11_io_P_sign;
  wire       [1:0]    expAB_1_11_io_P_flag;
  wire       [9:0]    expAB_1_12_io_P_expn;
  wire                expAB_1_12_io_P_sign;
  wire       [1:0]    expAB_1_12_io_P_flag;
  wire       [9:0]    expAB_1_13_io_P_expn;
  wire                expAB_1_13_io_P_sign;
  wire       [1:0]    expAB_1_13_io_P_flag;
  wire       [9:0]    expAB_1_14_io_P_expn;
  wire                expAB_1_14_io_P_sign;
  wire       [1:0]    expAB_1_14_io_P_flag;
  wire       [9:0]    expAB_1_15_io_P_expn;
  wire                expAB_1_15_io_P_sign;
  wire       [1:0]    expAB_1_15_io_P_flag;
  wire       [9:0]    nrshP_0_io_P_nrsh_0;
  wire       [9:0]    nrshP_0_io_P_nrsh_1;
  wire       [9:0]    nrshP_0_io_P_nrsh_2;
  wire       [9:0]    nrshP_0_io_P_nrsh_3;
  wire       [9:0]    nrshP_0_io_P_nrsh_4;
  wire       [9:0]    nrshP_0_io_P_nrsh_5;
  wire       [9:0]    nrshP_0_io_P_nrsh_6;
  wire       [9:0]    nrshP_0_io_P_nrsh_7;
  wire       [9:0]    nrshP_0_io_P_nrsh_8;
  wire       [9:0]    nrshP_0_io_P_nrsh_9;
  wire       [9:0]    nrshP_0_io_P_nrsh_10;
  wire       [9:0]    nrshP_0_io_P_nrsh_11;
  wire       [9:0]    nrshP_0_io_P_nrsh_12;
  wire       [9:0]    nrshP_0_io_P_nrsh_13;
  wire       [9:0]    nrshP_0_io_P_nrsh_14;
  wire       [9:0]    nrshP_0_io_P_nrsh_15;
  wire       [9:0]    nrshP_0_io_P_nrsh_16;
  wire       [9:0]    nrshP_0_io_Q_expn;
  wire                nrshP_0_io_Q_sign;
  wire       [1:0]    nrshP_0_io_Q_flag;
  wire       [9:0]    nrshP_1_io_P_nrsh_0;
  wire       [9:0]    nrshP_1_io_P_nrsh_1;
  wire       [9:0]    nrshP_1_io_P_nrsh_2;
  wire       [9:0]    nrshP_1_io_P_nrsh_3;
  wire       [9:0]    nrshP_1_io_P_nrsh_4;
  wire       [9:0]    nrshP_1_io_P_nrsh_5;
  wire       [9:0]    nrshP_1_io_P_nrsh_6;
  wire       [9:0]    nrshP_1_io_P_nrsh_7;
  wire       [9:0]    nrshP_1_io_P_nrsh_8;
  wire       [9:0]    nrshP_1_io_P_nrsh_9;
  wire       [9:0]    nrshP_1_io_P_nrsh_10;
  wire       [9:0]    nrshP_1_io_P_nrsh_11;
  wire       [9:0]    nrshP_1_io_P_nrsh_12;
  wire       [9:0]    nrshP_1_io_P_nrsh_13;
  wire       [9:0]    nrshP_1_io_P_nrsh_14;
  wire       [9:0]    nrshP_1_io_P_nrsh_15;
  wire       [9:0]    nrshP_1_io_P_nrsh_16;
  wire       [9:0]    nrshP_1_io_Q_expn;
  wire                nrshP_1_io_Q_sign;
  wire       [1:0]    nrshP_1_io_Q_flag;
  wire       [55:0]   alignerFP_P_0_0_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_1_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_2_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_3_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_4_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_5_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_6_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_7_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_8_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_9_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_10_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_11_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_12_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_13_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_14_io_o_mtsa;
  wire       [55:0]   alignerFP_P_0_15_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_0_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_1_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_2_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_3_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_4_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_5_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_6_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_7_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_8_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_9_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_10_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_11_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_12_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_13_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_14_io_o_mtsa;
  wire       [55:0]   alignerFP_P_1_15_io_o_mtsa;
  wire       [55:0]   alignerFP_C_0_io_o_mtsa;
  wire       [55:0]   alignerFP_C_1_io_o_mtsa;
  wire       [55:0]   addTreeInst_0_io_o_data;
  wire       [55:0]   addTreeInst_1_io_o_data;
  wire       [23:0]   roundInst_0_io_o_mtsa;
  wire       [9:0]    roundInst_0_io_o_expn;
  wire                roundInst_0_io_o_sign;
  wire       [1:0]    roundInst_0_io_o_flag;
  wire       [23:0]   roundInst_1_io_o_mtsa;
  wire       [9:0]    roundInst_1_io_o_expn;
  wire                roundInst_1_io_o_sign;
  wire       [1:0]    roundInst_1_io_o_flag;
  wire       [31:0]   packer_0_io_pack;
  wire                packer_0_io_isNaN;
  wire                packer_0_io_isInf;
  wire       [31:0]   packer_1_io_pack;
  wire                packer_1_io_isNaN;
  wire                packer_1_io_isInf;
  wire       [55:0]   fPalignUnit_40_io_o_mtsa;
  wire       [55:0]   adderTree_8_io_o_data;
  wire       [55:0]   fPalignUnit_41_io_o_mtsa;
  wire       [55:0]   adderTree_9_io_o_data;
  wire       [55:0]   fPalignUnit_42_io_o_mtsa;
  wire       [55:0]   adderTree_10_io_o_data;
  wire       [55:0]   fPalignUnit_43_io_o_mtsa;
  wire       [55:0]   adderTree_11_io_o_data;
  wire       [55:0]   fPalignUnit_44_io_o_mtsa;
  wire       [55:0]   adderTree_12_io_o_data;
  wire       [55:0]   fPalignUnit_45_io_o_mtsa;
  wire       [55:0]   adderTree_13_io_o_data;
  wire       [31:0]   intAdder_0_io_o_D;
  wire                intAdder_0_io_ovf;
  wire       [31:0]   intAdder_1_io_o_D;
  wire                intAdder_1_io_ovf;
  wire       [31:0]   intAdder_2_io_o_D;
  wire                intAdder_2_io_ovf;
  wire       [31:0]   intAdder_3_io_o_D;
  wire                intAdder_3_io_ovf;
  wire       [55:0]   _zz_io_i_data_0_8;
  wire       [55:0]   _zz_io_i_data_1_8;
  wire       [55:0]   _zz_io_i_data_2_8;
  wire       [55:0]   _zz_io_i_data_3_8;
  wire       [55:0]   _zz_io_i_data_4_8;
  wire       [55:0]   _zz_io_i_data_5_8;
  wire       [55:0]   _zz_io_i_data_6_8;
  wire       [55:0]   _zz_io_i_data_7_8;
  wire       [55:0]   _zz_io_i_data_8_8;
  wire       [55:0]   _zz_io_i_data_9_8;
  wire       [55:0]   _zz_io_i_data_10_8;
  wire       [55:0]   _zz_io_i_data_11_8;
  wire       [55:0]   _zz_io_i_data_12_8;
  wire       [55:0]   _zz_io_i_data_13_8;
  wire       [55:0]   _zz_io_i_data_14_8;
  wire       [55:0]   _zz_io_i_data_15_8;
  wire       [55:0]   _zz_io_i_data_0_9;
  wire       [55:0]   _zz_io_i_data_1_9;
  wire       [55:0]   _zz_io_i_data_2_9;
  wire       [55:0]   _zz_io_i_data_3_9;
  wire       [55:0]   _zz_io_i_data_4_9;
  wire       [55:0]   _zz_io_i_data_5_9;
  wire       [55:0]   _zz_io_i_data_6_9;
  wire       [55:0]   _zz_io_i_data_7_9;
  wire       [55:0]   _zz_io_i_data_8_9;
  wire       [55:0]   _zz_io_i_data_9_9;
  wire       [55:0]   _zz_io_i_data_10_9;
  wire       [55:0]   _zz_io_i_data_11_9;
  wire       [55:0]   _zz_io_i_data_12_9;
  wire       [55:0]   _zz_io_i_data_13_9;
  wire       [55:0]   _zz_io_i_data_14_9;
  wire       [55:0]   _zz_io_i_data_15_9;
  reg        [2:0]    arithMode;
  wire                isIntMode;
  reg        [1:0]    ABpackMode;
  reg        [1:0]    CDpackMode;
  wire       [31:0]   vecA_0;
  wire       [31:0]   vecA_1;
  wire       [31:0]   vecA_2;
  wire       [31:0]   vecA_3;
  wire       [31:0]   vecA_4;
  wire       [31:0]   vecA_5;
  wire       [31:0]   vecA_6;
  wire       [31:0]   vecA_7;
  wire       [31:0]   vecA_8;
  wire       [31:0]   vecA_9;
  wire       [31:0]   vecA_10;
  wire       [31:0]   vecA_11;
  wire       [31:0]   vecA_12;
  wire       [31:0]   vecA_13;
  wire       [31:0]   vecA_14;
  wire       [31:0]   vecA_15;
  wire       [31:0]   vecB_0;
  wire       [31:0]   vecB_1;
  wire       [31:0]   vecB_2;
  wire       [31:0]   vecB_3;
  wire       [31:0]   vecB_4;
  wire       [31:0]   vecB_5;
  wire       [31:0]   vecB_6;
  wire       [31:0]   vecB_7;
  wire       [31:0]   vecB_8;
  wire       [31:0]   vecB_9;
  wire       [31:0]   vecB_10;
  wire       [31:0]   vecB_11;
  wire       [31:0]   vecB_12;
  wire       [31:0]   vecB_13;
  wire       [31:0]   vecB_14;
  wire       [31:0]   vecB_15;
  wire       [31:0]   vecC_0;
  wire       [31:0]   vecC_1;
  wire       [31:0]   vecC_2;
  wire       [31:0]   vecC_3;
  reg                 io_P_sign_delay_1;
  reg                 io_P_sign_delay_2;
  reg                 io_P_sign_delay_3;
  reg                 io_P_sign_delay_1_1;
  reg                 io_P_sign_delay_2_1;
  reg                 io_P_sign_delay_3_1;
  reg                 io_P_sign_delay_1_2;
  reg                 io_P_sign_delay_2_2;
  reg                 io_P_sign_delay_3_2;
  reg                 io_P_sign_delay_1_3;
  reg                 io_P_sign_delay_2_3;
  reg                 io_P_sign_delay_3_3;
  reg                 io_P_sign_delay_1_4;
  reg                 io_P_sign_delay_2_4;
  reg                 io_P_sign_delay_3_4;
  reg                 io_P_sign_delay_1_5;
  reg                 io_P_sign_delay_2_5;
  reg                 io_P_sign_delay_3_5;
  reg                 io_P_sign_delay_1_6;
  reg                 io_P_sign_delay_2_6;
  reg                 io_P_sign_delay_3_6;
  reg                 io_P_sign_delay_1_7;
  reg                 io_P_sign_delay_2_7;
  reg                 io_P_sign_delay_3_7;
  reg                 io_P_sign_delay_1_8;
  reg                 io_P_sign_delay_2_8;
  reg                 io_P_sign_delay_3_8;
  reg                 io_P_sign_delay_1_9;
  reg                 io_P_sign_delay_2_9;
  reg                 io_P_sign_delay_3_9;
  reg                 io_P_sign_delay_1_10;
  reg                 io_P_sign_delay_2_10;
  reg                 io_P_sign_delay_3_10;
  reg                 io_P_sign_delay_1_11;
  reg                 io_P_sign_delay_2_11;
  reg                 io_P_sign_delay_3_11;
  reg                 io_P_sign_delay_1_12;
  reg                 io_P_sign_delay_2_12;
  reg                 io_P_sign_delay_3_12;
  reg                 io_P_sign_delay_1_13;
  reg                 io_P_sign_delay_2_13;
  reg                 io_P_sign_delay_3_13;
  reg                 io_P_sign_delay_1_14;
  reg                 io_P_sign_delay_2_14;
  reg                 io_P_sign_delay_3_14;
  reg                 io_P_sign_delay_1_15;
  reg                 io_P_sign_delay_2_15;
  reg                 io_P_sign_delay_3_15;
  reg                 io_P_sign_delay_1_16;
  reg                 io_P_sign_delay_2_16;
  reg                 io_P_sign_delay_3_16;
  reg                 io_P_sign_delay_1_17;
  reg                 io_P_sign_delay_2_17;
  reg                 io_P_sign_delay_3_17;
  reg                 io_P_sign_delay_1_18;
  reg                 io_P_sign_delay_2_18;
  reg                 io_P_sign_delay_3_18;
  reg                 io_P_sign_delay_1_19;
  reg                 io_P_sign_delay_2_19;
  reg                 io_P_sign_delay_3_19;
  reg                 io_P_sign_delay_1_20;
  reg                 io_P_sign_delay_2_20;
  reg                 io_P_sign_delay_3_20;
  reg                 io_P_sign_delay_1_21;
  reg                 io_P_sign_delay_2_21;
  reg                 io_P_sign_delay_3_21;
  reg                 io_P_sign_delay_1_22;
  reg                 io_P_sign_delay_2_22;
  reg                 io_P_sign_delay_3_22;
  reg                 io_P_sign_delay_1_23;
  reg                 io_P_sign_delay_2_23;
  reg                 io_P_sign_delay_3_23;
  reg                 io_P_sign_delay_1_24;
  reg                 io_P_sign_delay_2_24;
  reg                 io_P_sign_delay_3_24;
  reg                 io_P_sign_delay_1_25;
  reg                 io_P_sign_delay_2_25;
  reg                 io_P_sign_delay_3_25;
  reg                 io_P_sign_delay_1_26;
  reg                 io_P_sign_delay_2_26;
  reg                 io_P_sign_delay_3_26;
  reg                 io_P_sign_delay_1_27;
  reg                 io_P_sign_delay_2_27;
  reg                 io_P_sign_delay_3_27;
  reg                 io_P_sign_delay_1_28;
  reg                 io_P_sign_delay_2_28;
  reg                 io_P_sign_delay_3_28;
  reg                 io_P_sign_delay_1_29;
  reg                 io_P_sign_delay_2_29;
  reg                 io_P_sign_delay_3_29;
  reg                 io_P_sign_delay_1_30;
  reg                 io_P_sign_delay_2_30;
  reg                 io_P_sign_delay_3_30;
  reg                 io_P_sign_delay_1_31;
  reg                 io_P_sign_delay_2_31;
  reg                 io_P_sign_delay_3_31;
  reg        [23:0]   io_c_mtsa_0_delay_1;
  reg        [23:0]   io_c_mtsa_0_delay_2;
  reg        [23:0]   io_c_mtsa_0_delay_3;
  reg                 io_c_sign_0_delay_1;
  reg                 io_c_sign_0_delay_2;
  reg                 io_c_sign_0_delay_3;
  reg        [23:0]   io_c_mtsa_1_delay_1;
  reg        [23:0]   io_c_mtsa_1_delay_2;
  reg        [23:0]   io_c_mtsa_1_delay_3;
  reg                 io_c_sign_1_delay_1;
  reg                 io_c_sign_1_delay_2;
  reg                 io_c_sign_1_delay_3;
  wire       [31:0]   _zz_io_i_data_0;
  wire       [15:0]   _zz_io_i_data_0_1;
  wire       [15:0]   _zz_io_i_data_0_2;
  reg        [55:0]   _zz_io_i_data_0_3;
  wire       [31:0]   _zz_io_i_data_1;
  wire       [15:0]   _zz_io_i_data_1_1;
  wire       [15:0]   _zz_io_i_data_1_2;
  reg        [55:0]   _zz_io_i_data_1_3;
  wire       [31:0]   _zz_io_i_data_2;
  wire       [15:0]   _zz_io_i_data_2_1;
  wire       [15:0]   _zz_io_i_data_2_2;
  reg        [55:0]   _zz_io_i_data_2_3;
  wire       [31:0]   _zz_io_i_data_3;
  wire       [15:0]   _zz_io_i_data_3_1;
  wire       [15:0]   _zz_io_i_data_3_2;
  reg        [55:0]   _zz_io_i_data_3_3;
  wire       [31:0]   _zz_io_i_data_4;
  wire       [15:0]   _zz_io_i_data_4_1;
  wire       [15:0]   _zz_io_i_data_4_2;
  reg        [55:0]   _zz_io_i_data_4_3;
  wire       [31:0]   _zz_io_i_data_5;
  wire       [15:0]   _zz_io_i_data_5_1;
  wire       [15:0]   _zz_io_i_data_5_2;
  reg        [55:0]   _zz_io_i_data_5_3;
  wire       [31:0]   _zz_io_i_data_6;
  wire       [15:0]   _zz_io_i_data_6_1;
  wire       [15:0]   _zz_io_i_data_6_2;
  reg        [55:0]   _zz_io_i_data_6_3;
  wire       [31:0]   _zz_io_i_data_7;
  wire       [15:0]   _zz_io_i_data_7_1;
  wire       [15:0]   _zz_io_i_data_7_2;
  reg        [55:0]   _zz_io_i_data_7_3;
  wire       [31:0]   _zz_io_i_data_8;
  wire       [15:0]   _zz_io_i_data_8_1;
  wire       [15:0]   _zz_io_i_data_8_2;
  reg        [55:0]   _zz_io_i_data_8_3;
  wire       [31:0]   _zz_io_i_data_9;
  wire       [15:0]   _zz_io_i_data_9_1;
  wire       [15:0]   _zz_io_i_data_9_2;
  reg        [55:0]   _zz_io_i_data_9_3;
  wire       [31:0]   _zz_io_i_data_10;
  wire       [15:0]   _zz_io_i_data_10_1;
  wire       [15:0]   _zz_io_i_data_10_2;
  reg        [55:0]   _zz_io_i_data_10_3;
  wire       [31:0]   _zz_io_i_data_11;
  wire       [15:0]   _zz_io_i_data_11_1;
  wire       [15:0]   _zz_io_i_data_11_2;
  reg        [55:0]   _zz_io_i_data_11_3;
  wire       [31:0]   _zz_io_i_data_12;
  wire       [15:0]   _zz_io_i_data_12_1;
  wire       [15:0]   _zz_io_i_data_12_2;
  reg        [55:0]   _zz_io_i_data_12_3;
  wire       [31:0]   _zz_io_i_data_13;
  wire       [15:0]   _zz_io_i_data_13_1;
  wire       [15:0]   _zz_io_i_data_13_2;
  reg        [55:0]   _zz_io_i_data_13_3;
  wire       [31:0]   _zz_io_i_data_14;
  wire       [15:0]   _zz_io_i_data_14_1;
  wire       [15:0]   _zz_io_i_data_14_2;
  reg        [55:0]   _zz_io_i_data_14_3;
  wire       [31:0]   _zz_io_i_data_15;
  wire       [15:0]   _zz_io_i_data_15_1;
  wire       [15:0]   _zz_io_i_data_15_2;
  reg        [55:0]   _zz_io_i_data_15_3;
  wire       [31:0]   _zz_io_i_data_0_4;
  wire       [15:0]   _zz_io_i_data_0_5;
  wire       [15:0]   _zz_io_i_data_0_6;
  reg        [55:0]   _zz_io_i_data_0_7;
  wire       [31:0]   _zz_io_i_data_1_4;
  wire       [15:0]   _zz_io_i_data_1_5;
  wire       [15:0]   _zz_io_i_data_1_6;
  reg        [55:0]   _zz_io_i_data_1_7;
  wire       [31:0]   _zz_io_i_data_2_4;
  wire       [15:0]   _zz_io_i_data_2_5;
  wire       [15:0]   _zz_io_i_data_2_6;
  reg        [55:0]   _zz_io_i_data_2_7;
  wire       [31:0]   _zz_io_i_data_3_4;
  wire       [15:0]   _zz_io_i_data_3_5;
  wire       [15:0]   _zz_io_i_data_3_6;
  reg        [55:0]   _zz_io_i_data_3_7;
  wire       [31:0]   _zz_io_i_data_4_4;
  wire       [15:0]   _zz_io_i_data_4_5;
  wire       [15:0]   _zz_io_i_data_4_6;
  reg        [55:0]   _zz_io_i_data_4_7;
  wire       [31:0]   _zz_io_i_data_5_4;
  wire       [15:0]   _zz_io_i_data_5_5;
  wire       [15:0]   _zz_io_i_data_5_6;
  reg        [55:0]   _zz_io_i_data_5_7;
  wire       [31:0]   _zz_io_i_data_6_4;
  wire       [15:0]   _zz_io_i_data_6_5;
  wire       [15:0]   _zz_io_i_data_6_6;
  reg        [55:0]   _zz_io_i_data_6_7;
  wire       [31:0]   _zz_io_i_data_7_4;
  wire       [15:0]   _zz_io_i_data_7_5;
  wire       [15:0]   _zz_io_i_data_7_6;
  reg        [55:0]   _zz_io_i_data_7_7;
  wire       [31:0]   _zz_io_i_data_8_4;
  wire       [15:0]   _zz_io_i_data_8_5;
  wire       [15:0]   _zz_io_i_data_8_6;
  reg        [55:0]   _zz_io_i_data_8_7;
  wire       [31:0]   _zz_io_i_data_9_4;
  wire       [15:0]   _zz_io_i_data_9_5;
  wire       [15:0]   _zz_io_i_data_9_6;
  reg        [55:0]   _zz_io_i_data_9_7;
  wire       [31:0]   _zz_io_i_data_10_4;
  wire       [15:0]   _zz_io_i_data_10_5;
  wire       [15:0]   _zz_io_i_data_10_6;
  reg        [55:0]   _zz_io_i_data_10_7;
  wire       [31:0]   _zz_io_i_data_11_4;
  wire       [15:0]   _zz_io_i_data_11_5;
  wire       [15:0]   _zz_io_i_data_11_6;
  reg        [55:0]   _zz_io_i_data_11_7;
  wire       [31:0]   _zz_io_i_data_12_4;
  wire       [15:0]   _zz_io_i_data_12_5;
  wire       [15:0]   _zz_io_i_data_12_6;
  reg        [55:0]   _zz_io_i_data_12_7;
  wire       [31:0]   _zz_io_i_data_13_4;
  wire       [15:0]   _zz_io_i_data_13_5;
  wire       [15:0]   _zz_io_i_data_13_6;
  reg        [55:0]   _zz_io_i_data_13_7;
  wire       [31:0]   _zz_io_i_data_14_4;
  wire       [15:0]   _zz_io_i_data_14_5;
  wire       [15:0]   _zz_io_i_data_14_6;
  reg        [55:0]   _zz_io_i_data_14_7;
  wire       [31:0]   _zz_io_i_data_15_4;
  wire       [15:0]   _zz_io_i_data_15_5;
  wire       [15:0]   _zz_io_i_data_15_6;
  reg        [55:0]   _zz_io_i_data_15_7;
  reg        [9:0]    io_Q_expn_delay_1;
  reg        [9:0]    io_Q_expn_delay_2;
  reg        [9:0]    io_Q_expn_delay_3;
  reg        [9:0]    io_Q_expn_delay_4;
  reg        [9:0]    io_Q_expn_delay_5;
  reg                 io_Q_sign_delay_1;
  reg                 io_Q_sign_delay_2;
  reg                 io_Q_sign_delay_3;
  reg                 io_Q_sign_delay_4;
  reg                 io_Q_sign_delay_5;
  reg        [1:0]    io_Q_flag_delay_1;
  reg        [1:0]    io_Q_flag_delay_2;
  reg        [1:0]    io_Q_flag_delay_3;
  reg        [1:0]    io_Q_flag_delay_4;
  reg        [1:0]    io_Q_flag_delay_5;
  reg        [9:0]    io_Q_expn_delay_1_1;
  reg        [9:0]    io_Q_expn_delay_2_1;
  reg        [9:0]    io_Q_expn_delay_3_1;
  reg        [9:0]    io_Q_expn_delay_4_1;
  reg        [9:0]    io_Q_expn_delay_5_1;
  reg                 io_Q_sign_delay_1_1;
  reg                 io_Q_sign_delay_2_1;
  reg                 io_Q_sign_delay_3_1;
  reg                 io_Q_sign_delay_4_1;
  reg                 io_Q_sign_delay_5_1;
  reg        [1:0]    io_Q_flag_delay_1_1;
  reg        [1:0]    io_Q_flag_delay_2_1;
  reg        [1:0]    io_Q_flag_delay_3_1;
  reg        [1:0]    io_Q_flag_delay_4_1;
  reg        [1:0]    io_Q_flag_delay_5_1;
  reg        [31:0]   _zz_io_i_C;
  reg        [31:0]   _zz_io_i_C_1;
  reg        [31:0]   _zz_io_i_C_2;
  reg        [31:0]   _zz_io_i_C_3;
  reg        [31:0]   _zz_io_i_C_4;
  reg        [31:0]   _zz_io_i_C_5;
  reg        [31:0]   _zz_io_i_C_6;
  reg        [31:0]   _zz_io_i_C_7;
  reg        [31:0]   _zz_io_i_C_8;
  reg        [31:0]   _zz_io_i_C_9;
  reg        [31:0]   _zz_io_i_C_10;
  reg        [31:0]   _zz_io_i_C_11;
  reg        [31:0]   _zz_io_i_C_12;
  reg        [31:0]   _zz_io_i_C_13;
  reg        [31:0]   _zz_io_i_C_14;
  reg        [31:0]   _zz_io_i_C_15;
  reg        [31:0]   _zz_io_i_C_16;
  reg        [31:0]   _zz_io_i_C_17;
  reg        [31:0]   _zz_io_i_C_18;
  reg        [31:0]   _zz_io_i_C_19;
  reg        [31:0]   _zz_io_i_C_20;
  reg        [31:0]   _zz_io_i_C_21;
  reg        [31:0]   _zz_io_i_C_22;
  reg        [31:0]   _zz_io_i_C_23;
  reg        [31:0]   _zz_io_i_C_24;
  reg        [31:0]   _zz_io_i_C_25;
  reg        [31:0]   _zz_io_i_C_26;
  reg        [31:0]   _zz_io_i_C_27;
  reg        [31:0]   _zz_io_i_C_28;
  reg        [31:0]   _zz_io_i_C_29;
  reg        [31:0]   _zz_io_i_C_30;
  reg        [31:0]   _zz_io_i_C_31;
  reg        [31:0]   _zz_io_i_C_32;
  reg        [31:0]   _zz_io_i_C_33;
  reg        [31:0]   _zz_io_i_C_34;
  reg        [31:0]   _zz_io_i_C_35;
  wire       [31:0]   vecD_0;
  wire       [31:0]   vecD_1;
  wire       [31:0]   vecD_2;
  wire       [31:0]   vecD_3;
  `ifndef SYNTHESIS
  reg [63:0] io_op_string;
  reg [63:0] arithMode_string;
  reg [31:0] ABpackMode_string;
  reg [31:0] CDpackMode_string;
  reg [31:0] io_Q_flag_delay_1_string;
  reg [31:0] io_Q_flag_delay_2_string;
  reg [31:0] io_Q_flag_delay_3_string;
  reg [31:0] io_Q_flag_delay_4_string;
  reg [31:0] io_Q_flag_delay_5_string;
  reg [31:0] io_Q_flag_delay_1_1_string;
  reg [31:0] io_Q_flag_delay_2_1_string;
  reg [31:0] io_Q_flag_delay_3_1_string;
  reg [31:0] io_Q_flag_delay_4_1_string;
  reg [31:0] io_Q_flag_delay_5_1_string;
  `endif


  assign _zz_io_i_data_0_8 = _zz_io_i_data_0_3;
  assign _zz_io_i_data_1_8 = _zz_io_i_data_1_3;
  assign _zz_io_i_data_2_8 = _zz_io_i_data_2_3;
  assign _zz_io_i_data_3_8 = _zz_io_i_data_3_3;
  assign _zz_io_i_data_4_8 = _zz_io_i_data_4_3;
  assign _zz_io_i_data_5_8 = _zz_io_i_data_5_3;
  assign _zz_io_i_data_6_8 = _zz_io_i_data_6_3;
  assign _zz_io_i_data_7_8 = _zz_io_i_data_7_3;
  assign _zz_io_i_data_8_8 = _zz_io_i_data_8_3;
  assign _zz_io_i_data_9_8 = _zz_io_i_data_9_3;
  assign _zz_io_i_data_10_8 = _zz_io_i_data_10_3;
  assign _zz_io_i_data_11_8 = _zz_io_i_data_11_3;
  assign _zz_io_i_data_12_8 = _zz_io_i_data_12_3;
  assign _zz_io_i_data_13_8 = _zz_io_i_data_13_3;
  assign _zz_io_i_data_14_8 = _zz_io_i_data_14_3;
  assign _zz_io_i_data_15_8 = _zz_io_i_data_15_3;
  assign _zz_io_i_data_0_9 = _zz_io_i_data_0_7;
  assign _zz_io_i_data_1_9 = _zz_io_i_data_1_7;
  assign _zz_io_i_data_2_9 = _zz_io_i_data_2_7;
  assign _zz_io_i_data_3_9 = _zz_io_i_data_3_7;
  assign _zz_io_i_data_4_9 = _zz_io_i_data_4_7;
  assign _zz_io_i_data_5_9 = _zz_io_i_data_5_7;
  assign _zz_io_i_data_6_9 = _zz_io_i_data_6_7;
  assign _zz_io_i_data_7_9 = _zz_io_i_data_7_7;
  assign _zz_io_i_data_8_9 = _zz_io_i_data_8_7;
  assign _zz_io_i_data_9_9 = _zz_io_i_data_9_7;
  assign _zz_io_i_data_10_9 = _zz_io_i_data_10_7;
  assign _zz_io_i_data_11_9 = _zz_io_i_data_11_7;
  assign _zz_io_i_data_12_9 = _zz_io_i_data_12_7;
  assign _zz_io_i_data_13_9 = _zz_io_i_data_13_7;
  assign _zz_io_i_data_14_9 = _zz_io_i_data_14_7;
  assign _zz_io_i_data_15_9 = _zz_io_i_data_15_7;
  mulUnit mulUnit_17 (
    .io_op     (                          ), //i
    .io_A_mtsa (                          ), //i
    .io_B_mtsa (                          ), //i
    .io_P_mtsa (mulUnit_17_io_P_mtsa[63:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expnAddUnit_34 (
    .io_op     (                             ), //i
    .io_A_expn (                             ), //i
    .io_A_sign (                             ), //i
    .io_A_flag (                             ), //i
    .io_B_expn (                             ), //i
    .io_B_sign (                             ), //i
    .io_B_flag (                             ), //i
    .io_P_expn (expnAddUnit_34_io_P_expn[9:0]), //o
    .io_P_sign (expnAddUnit_34_io_P_sign     ), //o
    .io_P_flag (expnAddUnit_34_io_P_flag[1:0]), //o
    .clk       (clk                          ), //i
    .resetn    (resetn                       )  //i
  );
  nrshUnit nrshUnit_3 (
    .io_P_expn_0  (                            ), //i
    .io_P_expn_1  (                            ), //i
    .io_P_expn_2  (                            ), //i
    .io_P_expn_3  (                            ), //i
    .io_P_expn_4  (                            ), //i
    .io_P_expn_5  (                            ), //i
    .io_P_expn_6  (                            ), //i
    .io_P_expn_7  (                            ), //i
    .io_P_expn_8  (                            ), //i
    .io_P_expn_9  (                            ), //i
    .io_P_expn_10 (                            ), //i
    .io_P_expn_11 (                            ), //i
    .io_P_expn_12 (                            ), //i
    .io_P_expn_13 (                            ), //i
    .io_P_expn_14 (                            ), //i
    .io_P_expn_15 (                            ), //i
    .io_P_expn_16 (                            ), //i
    .io_P_sign_0  (                            ), //i
    .io_P_sign_1  (                            ), //i
    .io_P_sign_2  (                            ), //i
    .io_P_sign_3  (                            ), //i
    .io_P_sign_4  (                            ), //i
    .io_P_sign_5  (                            ), //i
    .io_P_sign_6  (                            ), //i
    .io_P_sign_7  (                            ), //i
    .io_P_sign_8  (                            ), //i
    .io_P_sign_9  (                            ), //i
    .io_P_sign_10 (                            ), //i
    .io_P_sign_11 (                            ), //i
    .io_P_sign_12 (                            ), //i
    .io_P_sign_13 (                            ), //i
    .io_P_sign_14 (                            ), //i
    .io_P_sign_15 (                            ), //i
    .io_P_sign_16 (                            ), //i
    .io_P_flag_0  (                            ), //i
    .io_P_flag_1  (                            ), //i
    .io_P_flag_2  (                            ), //i
    .io_P_flag_3  (                            ), //i
    .io_P_flag_4  (                            ), //i
    .io_P_flag_5  (                            ), //i
    .io_P_flag_6  (                            ), //i
    .io_P_flag_7  (                            ), //i
    .io_P_flag_8  (                            ), //i
    .io_P_flag_9  (                            ), //i
    .io_P_flag_10 (                            ), //i
    .io_P_flag_11 (                            ), //i
    .io_P_flag_12 (                            ), //i
    .io_P_flag_13 (                            ), //i
    .io_P_flag_14 (                            ), //i
    .io_P_flag_15 (                            ), //i
    .io_P_flag_16 (                            ), //i
    .io_P_nrsh_0  (nrshUnit_3_io_P_nrsh_0[9:0] ), //o
    .io_P_nrsh_1  (nrshUnit_3_io_P_nrsh_1[9:0] ), //o
    .io_P_nrsh_2  (nrshUnit_3_io_P_nrsh_2[9:0] ), //o
    .io_P_nrsh_3  (nrshUnit_3_io_P_nrsh_3[9:0] ), //o
    .io_P_nrsh_4  (nrshUnit_3_io_P_nrsh_4[9:0] ), //o
    .io_P_nrsh_5  (nrshUnit_3_io_P_nrsh_5[9:0] ), //o
    .io_P_nrsh_6  (nrshUnit_3_io_P_nrsh_6[9:0] ), //o
    .io_P_nrsh_7  (nrshUnit_3_io_P_nrsh_7[9:0] ), //o
    .io_P_nrsh_8  (nrshUnit_3_io_P_nrsh_8[9:0] ), //o
    .io_P_nrsh_9  (nrshUnit_3_io_P_nrsh_9[9:0] ), //o
    .io_P_nrsh_10 (nrshUnit_3_io_P_nrsh_10[9:0]), //o
    .io_P_nrsh_11 (nrshUnit_3_io_P_nrsh_11[9:0]), //o
    .io_P_nrsh_12 (nrshUnit_3_io_P_nrsh_12[9:0]), //o
    .io_P_nrsh_13 (nrshUnit_3_io_P_nrsh_13[9:0]), //o
    .io_P_nrsh_14 (nrshUnit_3_io_P_nrsh_14[9:0]), //o
    .io_P_nrsh_15 (nrshUnit_3_io_P_nrsh_15[9:0]), //o
    .io_P_nrsh_16 (nrshUnit_3_io_P_nrsh_16[9:0]), //o
    .io_Q_expn    (nrshUnit_3_io_Q_expn[9:0]   ), //o
    .io_Q_sign    (nrshUnit_3_io_Q_sign        ), //o
    .io_Q_flag    (nrshUnit_3_io_Q_flag[1:0]   ), //o
    .clk          (clk                         ), //i
    .resetn       (resetn                      )  //i
  );
  unPackUnit unpackerA_0 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_0[31:0]              ), //i
    .io_mtsa   (unpackerA_0_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_0_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_0_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_0_io_sign_0     ), //o
    .io_sign_1 (unpackerA_0_io_sign_1     ), //o
    .io_flag_0 (unpackerA_0_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_0_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_1 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_1[31:0]              ), //i
    .io_mtsa   (unpackerA_1_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_1_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_1_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_1_io_sign_0     ), //o
    .io_sign_1 (unpackerA_1_io_sign_1     ), //o
    .io_flag_0 (unpackerA_1_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_1_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_2 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_2[31:0]              ), //i
    .io_mtsa   (unpackerA_2_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_2_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_2_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_2_io_sign_0     ), //o
    .io_sign_1 (unpackerA_2_io_sign_1     ), //o
    .io_flag_0 (unpackerA_2_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_2_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_3 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_3[31:0]              ), //i
    .io_mtsa   (unpackerA_3_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_3_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_3_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_3_io_sign_0     ), //o
    .io_sign_1 (unpackerA_3_io_sign_1     ), //o
    .io_flag_0 (unpackerA_3_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_3_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_4 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_4[31:0]              ), //i
    .io_mtsa   (unpackerA_4_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_4_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_4_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_4_io_sign_0     ), //o
    .io_sign_1 (unpackerA_4_io_sign_1     ), //o
    .io_flag_0 (unpackerA_4_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_4_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_5 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_5[31:0]              ), //i
    .io_mtsa   (unpackerA_5_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_5_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_5_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_5_io_sign_0     ), //o
    .io_sign_1 (unpackerA_5_io_sign_1     ), //o
    .io_flag_0 (unpackerA_5_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_5_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_6 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_6[31:0]              ), //i
    .io_mtsa   (unpackerA_6_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_6_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_6_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_6_io_sign_0     ), //o
    .io_sign_1 (unpackerA_6_io_sign_1     ), //o
    .io_flag_0 (unpackerA_6_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_6_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_7 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_7[31:0]              ), //i
    .io_mtsa   (unpackerA_7_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_7_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_7_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_7_io_sign_0     ), //o
    .io_sign_1 (unpackerA_7_io_sign_1     ), //o
    .io_flag_0 (unpackerA_7_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_7_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_8 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_8[31:0]              ), //i
    .io_mtsa   (unpackerA_8_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_8_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_8_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_8_io_sign_0     ), //o
    .io_sign_1 (unpackerA_8_io_sign_1     ), //o
    .io_flag_0 (unpackerA_8_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_8_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_9 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecA_9[31:0]              ), //i
    .io_mtsa   (unpackerA_9_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_9_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_9_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_9_io_sign_0     ), //o
    .io_sign_1 (unpackerA_9_io_sign_1     ), //o
    .io_flag_0 (unpackerA_9_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_9_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerA_10 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecA_10[31:0]              ), //i
    .io_mtsa   (unpackerA_10_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_10_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_10_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_10_io_sign_0     ), //o
    .io_sign_1 (unpackerA_10_io_sign_1     ), //o
    .io_flag_0 (unpackerA_10_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_10_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerA_11 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecA_11[31:0]              ), //i
    .io_mtsa   (unpackerA_11_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_11_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_11_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_11_io_sign_0     ), //o
    .io_sign_1 (unpackerA_11_io_sign_1     ), //o
    .io_flag_0 (unpackerA_11_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_11_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerA_12 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecA_12[31:0]              ), //i
    .io_mtsa   (unpackerA_12_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_12_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_12_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_12_io_sign_0     ), //o
    .io_sign_1 (unpackerA_12_io_sign_1     ), //o
    .io_flag_0 (unpackerA_12_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_12_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerA_13 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecA_13[31:0]              ), //i
    .io_mtsa   (unpackerA_13_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_13_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_13_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_13_io_sign_0     ), //o
    .io_sign_1 (unpackerA_13_io_sign_1     ), //o
    .io_flag_0 (unpackerA_13_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_13_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerA_14 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecA_14[31:0]              ), //i
    .io_mtsa   (unpackerA_14_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_14_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_14_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_14_io_sign_0     ), //o
    .io_sign_1 (unpackerA_14_io_sign_1     ), //o
    .io_flag_0 (unpackerA_14_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_14_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerA_15 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecA_15[31:0]              ), //i
    .io_mtsa   (unpackerA_15_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerA_15_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerA_15_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerA_15_io_sign_0     ), //o
    .io_sign_1 (unpackerA_15_io_sign_1     ), //o
    .io_flag_0 (unpackerA_15_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerA_15_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerB_0 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_0[31:0]              ), //i
    .io_mtsa   (unpackerB_0_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_0_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_0_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_0_io_sign_0     ), //o
    .io_sign_1 (unpackerB_0_io_sign_1     ), //o
    .io_flag_0 (unpackerB_0_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_0_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_1 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_1[31:0]              ), //i
    .io_mtsa   (unpackerB_1_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_1_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_1_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_1_io_sign_0     ), //o
    .io_sign_1 (unpackerB_1_io_sign_1     ), //o
    .io_flag_0 (unpackerB_1_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_1_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_2 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_2[31:0]              ), //i
    .io_mtsa   (unpackerB_2_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_2_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_2_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_2_io_sign_0     ), //o
    .io_sign_1 (unpackerB_2_io_sign_1     ), //o
    .io_flag_0 (unpackerB_2_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_2_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_3 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_3[31:0]              ), //i
    .io_mtsa   (unpackerB_3_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_3_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_3_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_3_io_sign_0     ), //o
    .io_sign_1 (unpackerB_3_io_sign_1     ), //o
    .io_flag_0 (unpackerB_3_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_3_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_4 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_4[31:0]              ), //i
    .io_mtsa   (unpackerB_4_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_4_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_4_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_4_io_sign_0     ), //o
    .io_sign_1 (unpackerB_4_io_sign_1     ), //o
    .io_flag_0 (unpackerB_4_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_4_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_5 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_5[31:0]              ), //i
    .io_mtsa   (unpackerB_5_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_5_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_5_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_5_io_sign_0     ), //o
    .io_sign_1 (unpackerB_5_io_sign_1     ), //o
    .io_flag_0 (unpackerB_5_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_5_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_6 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_6[31:0]              ), //i
    .io_mtsa   (unpackerB_6_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_6_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_6_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_6_io_sign_0     ), //o
    .io_sign_1 (unpackerB_6_io_sign_1     ), //o
    .io_flag_0 (unpackerB_6_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_6_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_7 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_7[31:0]              ), //i
    .io_mtsa   (unpackerB_7_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_7_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_7_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_7_io_sign_0     ), //o
    .io_sign_1 (unpackerB_7_io_sign_1     ), //o
    .io_flag_0 (unpackerB_7_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_7_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_8 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_8[31:0]              ), //i
    .io_mtsa   (unpackerB_8_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_8_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_8_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_8_io_sign_0     ), //o
    .io_sign_1 (unpackerB_8_io_sign_1     ), //o
    .io_flag_0 (unpackerB_8_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_8_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_9 (
    .io_op     (ABpackMode[1:0]           ), //i
    .io_xf     (vecB_9[31:0]              ), //i
    .io_mtsa   (unpackerB_9_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_9_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_9_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_9_io_sign_0     ), //o
    .io_sign_1 (unpackerB_9_io_sign_1     ), //o
    .io_flag_0 (unpackerB_9_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_9_io_flag_1[1:0]), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  unPackUnit unpackerB_10 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecB_10[31:0]              ), //i
    .io_mtsa   (unpackerB_10_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_10_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_10_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_10_io_sign_0     ), //o
    .io_sign_1 (unpackerB_10_io_sign_1     ), //o
    .io_flag_0 (unpackerB_10_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_10_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerB_11 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecB_11[31:0]              ), //i
    .io_mtsa   (unpackerB_11_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_11_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_11_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_11_io_sign_0     ), //o
    .io_sign_1 (unpackerB_11_io_sign_1     ), //o
    .io_flag_0 (unpackerB_11_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_11_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerB_12 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecB_12[31:0]              ), //i
    .io_mtsa   (unpackerB_12_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_12_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_12_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_12_io_sign_0     ), //o
    .io_sign_1 (unpackerB_12_io_sign_1     ), //o
    .io_flag_0 (unpackerB_12_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_12_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerB_13 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecB_13[31:0]              ), //i
    .io_mtsa   (unpackerB_13_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_13_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_13_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_13_io_sign_0     ), //o
    .io_sign_1 (unpackerB_13_io_sign_1     ), //o
    .io_flag_0 (unpackerB_13_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_13_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerB_14 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecB_14[31:0]              ), //i
    .io_mtsa   (unpackerB_14_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_14_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_14_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_14_io_sign_0     ), //o
    .io_sign_1 (unpackerB_14_io_sign_1     ), //o
    .io_flag_0 (unpackerB_14_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_14_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  unPackUnit unpackerB_15 (
    .io_op     (ABpackMode[1:0]            ), //i
    .io_xf     (vecB_15[31:0]              ), //i
    .io_mtsa   (unpackerB_15_io_mtsa[31:0] ), //o
    .io_expn_0 (unpackerB_15_io_expn_0[7:0]), //o
    .io_expn_1 (unpackerB_15_io_expn_1[7:0]), //o
    .io_sign_0 (unpackerB_15_io_sign_0     ), //o
    .io_sign_1 (unpackerB_15_io_sign_1     ), //o
    .io_flag_0 (unpackerB_15_io_flag_0[1:0]), //o
    .io_flag_1 (unpackerB_15_io_flag_1[1:0]), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  vecCPath pathCInst (
    .io_op       (arithMode[2:0]             ), //i
    .io_vecC_0   (vecC_0[31:0]               ), //i
    .io_vecC_1   (vecC_1[31:0]               ), //i
    .io_c_mtsa_0 (pathCInst_io_c_mtsa_0[23:0]), //o
    .io_c_mtsa_1 (pathCInst_io_c_mtsa_1[23:0]), //o
    .io_c_expn_0 (pathCInst_io_c_expn_0[9:0] ), //o
    .io_c_expn_1 (pathCInst_io_c_expn_1[9:0] ), //o
    .io_c_sign_0 (pathCInst_io_c_sign_0      ), //o
    .io_c_sign_1 (pathCInst_io_c_sign_1      ), //o
    .io_c_flag_0 (pathCInst_io_c_flag_0[1:0] ), //o
    .io_c_flag_1 (pathCInst_io_c_flag_1[1:0] ), //o
    .clk         (clk                        ), //i
    .resetn      (resetn                     )  //i
  );
  mulUnit mulAB_0 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_0_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_0_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_0_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_1 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_1_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_1_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_1_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_2 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_2_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_2_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_2_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_3 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_3_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_3_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_3_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_4 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_4_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_4_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_4_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_5 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_5_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_5_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_5_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_6 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_6_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_6_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_6_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_7 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_7_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_7_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_7_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_8 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_8_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_8_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_8_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_9 (
    .io_op     (arithMode[2:0]           ), //i
    .io_A_mtsa (unpackerA_9_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_9_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_9_io_P_mtsa[63:0]  ), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  mulUnit mulAB_10 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_mtsa (unpackerA_10_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_10_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_10_io_P_mtsa[63:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  mulUnit mulAB_11 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_mtsa (unpackerA_11_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_11_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_11_io_P_mtsa[63:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  mulUnit mulAB_12 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_mtsa (unpackerA_12_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_12_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_12_io_P_mtsa[63:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  mulUnit mulAB_13 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_mtsa (unpackerA_13_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_13_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_13_io_P_mtsa[63:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  mulUnit mulAB_14 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_mtsa (unpackerA_14_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_14_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_14_io_P_mtsa[63:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  mulUnit mulAB_15 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_mtsa (unpackerA_15_io_mtsa[31:0]), //i
    .io_B_mtsa (unpackerB_15_io_mtsa[31:0]), //i
    .io_P_mtsa (mulAB_15_io_P_mtsa[63:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_0 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_0_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_0_io_sign_0     ), //i
    .io_A_flag (unpackerA_0_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_0_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_0_io_sign_0     ), //i
    .io_B_flag (unpackerB_0_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_0_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_0_io_P_sign       ), //o
    .io_P_flag (expAB_0_0_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_1 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_1_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_1_io_sign_0     ), //i
    .io_A_flag (unpackerA_1_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_1_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_1_io_sign_0     ), //i
    .io_B_flag (unpackerB_1_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_1_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_1_io_P_sign       ), //o
    .io_P_flag (expAB_0_1_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_2 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_2_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_2_io_sign_0     ), //i
    .io_A_flag (unpackerA_2_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_2_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_2_io_sign_0     ), //i
    .io_B_flag (unpackerB_2_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_2_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_2_io_P_sign       ), //o
    .io_P_flag (expAB_0_2_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_3 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_3_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_3_io_sign_0     ), //i
    .io_A_flag (unpackerA_3_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_3_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_3_io_sign_0     ), //i
    .io_B_flag (unpackerB_3_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_3_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_3_io_P_sign       ), //o
    .io_P_flag (expAB_0_3_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_4 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_4_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_4_io_sign_0     ), //i
    .io_A_flag (unpackerA_4_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_4_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_4_io_sign_0     ), //i
    .io_B_flag (unpackerB_4_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_4_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_4_io_P_sign       ), //o
    .io_P_flag (expAB_0_4_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_5 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_5_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_5_io_sign_0     ), //i
    .io_A_flag (unpackerA_5_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_5_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_5_io_sign_0     ), //i
    .io_B_flag (unpackerB_5_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_5_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_5_io_P_sign       ), //o
    .io_P_flag (expAB_0_5_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_6 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_6_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_6_io_sign_0     ), //i
    .io_A_flag (unpackerA_6_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_6_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_6_io_sign_0     ), //i
    .io_B_flag (unpackerB_6_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_6_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_6_io_P_sign       ), //o
    .io_P_flag (expAB_0_6_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_7 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_7_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_7_io_sign_0     ), //i
    .io_A_flag (unpackerA_7_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_7_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_7_io_sign_0     ), //i
    .io_B_flag (unpackerB_7_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_7_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_7_io_P_sign       ), //o
    .io_P_flag (expAB_0_7_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_8 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_8_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_8_io_sign_0     ), //i
    .io_A_flag (unpackerA_8_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_8_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_8_io_sign_0     ), //i
    .io_B_flag (unpackerB_8_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_8_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_8_io_P_sign       ), //o
    .io_P_flag (expAB_0_8_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_9 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_9_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_9_io_sign_0     ), //i
    .io_A_flag (unpackerA_9_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_9_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_9_io_sign_0     ), //i
    .io_B_flag (unpackerB_9_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_9_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_9_io_P_sign       ), //o
    .io_P_flag (expAB_0_9_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_0_10 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_10_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_10_io_sign_0     ), //i
    .io_A_flag (unpackerA_10_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_10_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_10_io_sign_0     ), //i
    .io_B_flag (unpackerB_10_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_10_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_10_io_P_sign       ), //o
    .io_P_flag (expAB_0_10_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_0_11 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_11_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_11_io_sign_0     ), //i
    .io_A_flag (unpackerA_11_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_11_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_11_io_sign_0     ), //i
    .io_B_flag (unpackerB_11_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_11_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_11_io_P_sign       ), //o
    .io_P_flag (expAB_0_11_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_0_12 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_12_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_12_io_sign_0     ), //i
    .io_A_flag (unpackerA_12_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_12_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_12_io_sign_0     ), //i
    .io_B_flag (unpackerB_12_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_12_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_12_io_P_sign       ), //o
    .io_P_flag (expAB_0_12_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_0_13 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_13_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_13_io_sign_0     ), //i
    .io_A_flag (unpackerA_13_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_13_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_13_io_sign_0     ), //i
    .io_B_flag (unpackerB_13_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_13_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_13_io_P_sign       ), //o
    .io_P_flag (expAB_0_13_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_0_14 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_14_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_14_io_sign_0     ), //i
    .io_A_flag (unpackerA_14_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_14_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_14_io_sign_0     ), //i
    .io_B_flag (unpackerB_14_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_14_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_14_io_P_sign       ), //o
    .io_P_flag (expAB_0_14_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_0_15 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_15_io_expn_0[7:0]), //i
    .io_A_sign (unpackerA_15_io_sign_0     ), //i
    .io_A_flag (unpackerA_15_io_flag_0[1:0]), //i
    .io_B_expn (unpackerB_15_io_expn_0[7:0]), //i
    .io_B_sign (unpackerB_15_io_sign_0     ), //i
    .io_B_flag (unpackerB_15_io_flag_0[1:0]), //i
    .io_P_expn (expAB_0_15_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_0_15_io_P_sign       ), //o
    .io_P_flag (expAB_0_15_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_1_0 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_0_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_0_io_sign_1     ), //i
    .io_A_flag (unpackerA_0_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_0_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_0_io_sign_1     ), //i
    .io_B_flag (unpackerB_0_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_0_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_0_io_P_sign       ), //o
    .io_P_flag (expAB_1_0_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_1 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_1_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_1_io_sign_1     ), //i
    .io_A_flag (unpackerA_1_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_1_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_1_io_sign_1     ), //i
    .io_B_flag (unpackerB_1_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_1_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_1_io_P_sign       ), //o
    .io_P_flag (expAB_1_1_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_2 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_2_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_2_io_sign_1     ), //i
    .io_A_flag (unpackerA_2_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_2_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_2_io_sign_1     ), //i
    .io_B_flag (unpackerB_2_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_2_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_2_io_P_sign       ), //o
    .io_P_flag (expAB_1_2_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_3 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_3_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_3_io_sign_1     ), //i
    .io_A_flag (unpackerA_3_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_3_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_3_io_sign_1     ), //i
    .io_B_flag (unpackerB_3_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_3_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_3_io_P_sign       ), //o
    .io_P_flag (expAB_1_3_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_4 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_4_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_4_io_sign_1     ), //i
    .io_A_flag (unpackerA_4_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_4_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_4_io_sign_1     ), //i
    .io_B_flag (unpackerB_4_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_4_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_4_io_P_sign       ), //o
    .io_P_flag (expAB_1_4_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_5 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_5_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_5_io_sign_1     ), //i
    .io_A_flag (unpackerA_5_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_5_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_5_io_sign_1     ), //i
    .io_B_flag (unpackerB_5_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_5_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_5_io_P_sign       ), //o
    .io_P_flag (expAB_1_5_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_6 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_6_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_6_io_sign_1     ), //i
    .io_A_flag (unpackerA_6_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_6_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_6_io_sign_1     ), //i
    .io_B_flag (unpackerB_6_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_6_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_6_io_P_sign       ), //o
    .io_P_flag (expAB_1_6_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_7 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_7_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_7_io_sign_1     ), //i
    .io_A_flag (unpackerA_7_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_7_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_7_io_sign_1     ), //i
    .io_B_flag (unpackerB_7_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_7_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_7_io_P_sign       ), //o
    .io_P_flag (expAB_1_7_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_8 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_8_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_8_io_sign_1     ), //i
    .io_A_flag (unpackerA_8_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_8_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_8_io_sign_1     ), //i
    .io_B_flag (unpackerB_8_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_8_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_8_io_P_sign       ), //o
    .io_P_flag (expAB_1_8_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_9 (
    .io_op     (arithMode[2:0]            ), //i
    .io_A_expn (unpackerA_9_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_9_io_sign_1     ), //i
    .io_A_flag (unpackerA_9_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_9_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_9_io_sign_1     ), //i
    .io_B_flag (unpackerB_9_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_9_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_9_io_P_sign       ), //o
    .io_P_flag (expAB_1_9_io_P_flag[1:0]  ), //o
    .clk       (clk                       ), //i
    .resetn    (resetn                    )  //i
  );
  expnAddUnit expAB_1_10 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_10_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_10_io_sign_1     ), //i
    .io_A_flag (unpackerA_10_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_10_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_10_io_sign_1     ), //i
    .io_B_flag (unpackerB_10_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_10_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_10_io_P_sign       ), //o
    .io_P_flag (expAB_1_10_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_1_11 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_11_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_11_io_sign_1     ), //i
    .io_A_flag (unpackerA_11_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_11_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_11_io_sign_1     ), //i
    .io_B_flag (unpackerB_11_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_11_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_11_io_P_sign       ), //o
    .io_P_flag (expAB_1_11_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_1_12 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_12_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_12_io_sign_1     ), //i
    .io_A_flag (unpackerA_12_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_12_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_12_io_sign_1     ), //i
    .io_B_flag (unpackerB_12_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_12_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_12_io_P_sign       ), //o
    .io_P_flag (expAB_1_12_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_1_13 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_13_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_13_io_sign_1     ), //i
    .io_A_flag (unpackerA_13_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_13_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_13_io_sign_1     ), //i
    .io_B_flag (unpackerB_13_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_13_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_13_io_P_sign       ), //o
    .io_P_flag (expAB_1_13_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_1_14 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_14_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_14_io_sign_1     ), //i
    .io_A_flag (unpackerA_14_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_14_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_14_io_sign_1     ), //i
    .io_B_flag (unpackerB_14_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_14_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_14_io_P_sign       ), //o
    .io_P_flag (expAB_1_14_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  expnAddUnit expAB_1_15 (
    .io_op     (arithMode[2:0]             ), //i
    .io_A_expn (unpackerA_15_io_expn_1[7:0]), //i
    .io_A_sign (unpackerA_15_io_sign_1     ), //i
    .io_A_flag (unpackerA_15_io_flag_1[1:0]), //i
    .io_B_expn (unpackerB_15_io_expn_1[7:0]), //i
    .io_B_sign (unpackerB_15_io_sign_1     ), //i
    .io_B_flag (unpackerB_15_io_flag_1[1:0]), //i
    .io_P_expn (expAB_1_15_io_P_expn[9:0]  ), //o
    .io_P_sign (expAB_1_15_io_P_sign       ), //o
    .io_P_flag (expAB_1_15_io_P_flag[1:0]  ), //o
    .clk       (clk                        ), //i
    .resetn    (resetn                     )  //i
  );
  nrshUnit nrshP_0 (
    .io_P_expn_0  (expAB_0_0_io_P_expn[9:0]  ), //i
    .io_P_expn_1  (expAB_0_1_io_P_expn[9:0]  ), //i
    .io_P_expn_2  (expAB_0_2_io_P_expn[9:0]  ), //i
    .io_P_expn_3  (expAB_0_3_io_P_expn[9:0]  ), //i
    .io_P_expn_4  (expAB_0_4_io_P_expn[9:0]  ), //i
    .io_P_expn_5  (expAB_0_5_io_P_expn[9:0]  ), //i
    .io_P_expn_6  (expAB_0_6_io_P_expn[9:0]  ), //i
    .io_P_expn_7  (expAB_0_7_io_P_expn[9:0]  ), //i
    .io_P_expn_8  (expAB_0_8_io_P_expn[9:0]  ), //i
    .io_P_expn_9  (expAB_0_9_io_P_expn[9:0]  ), //i
    .io_P_expn_10 (expAB_0_10_io_P_expn[9:0] ), //i
    .io_P_expn_11 (expAB_0_11_io_P_expn[9:0] ), //i
    .io_P_expn_12 (expAB_0_12_io_P_expn[9:0] ), //i
    .io_P_expn_13 (expAB_0_13_io_P_expn[9:0] ), //i
    .io_P_expn_14 (expAB_0_14_io_P_expn[9:0] ), //i
    .io_P_expn_15 (expAB_0_15_io_P_expn[9:0] ), //i
    .io_P_expn_16 (pathCInst_io_c_expn_0[9:0]), //i
    .io_P_sign_0  (expAB_0_0_io_P_sign       ), //i
    .io_P_sign_1  (expAB_0_1_io_P_sign       ), //i
    .io_P_sign_2  (expAB_0_2_io_P_sign       ), //i
    .io_P_sign_3  (expAB_0_3_io_P_sign       ), //i
    .io_P_sign_4  (expAB_0_4_io_P_sign       ), //i
    .io_P_sign_5  (expAB_0_5_io_P_sign       ), //i
    .io_P_sign_6  (expAB_0_6_io_P_sign       ), //i
    .io_P_sign_7  (expAB_0_7_io_P_sign       ), //i
    .io_P_sign_8  (expAB_0_8_io_P_sign       ), //i
    .io_P_sign_9  (expAB_0_9_io_P_sign       ), //i
    .io_P_sign_10 (expAB_0_10_io_P_sign      ), //i
    .io_P_sign_11 (expAB_0_11_io_P_sign      ), //i
    .io_P_sign_12 (expAB_0_12_io_P_sign      ), //i
    .io_P_sign_13 (expAB_0_13_io_P_sign      ), //i
    .io_P_sign_14 (expAB_0_14_io_P_sign      ), //i
    .io_P_sign_15 (expAB_0_15_io_P_sign      ), //i
    .io_P_sign_16 (pathCInst_io_c_sign_0     ), //i
    .io_P_flag_0  (expAB_0_0_io_P_flag[1:0]  ), //i
    .io_P_flag_1  (expAB_0_1_io_P_flag[1:0]  ), //i
    .io_P_flag_2  (expAB_0_2_io_P_flag[1:0]  ), //i
    .io_P_flag_3  (expAB_0_3_io_P_flag[1:0]  ), //i
    .io_P_flag_4  (expAB_0_4_io_P_flag[1:0]  ), //i
    .io_P_flag_5  (expAB_0_5_io_P_flag[1:0]  ), //i
    .io_P_flag_6  (expAB_0_6_io_P_flag[1:0]  ), //i
    .io_P_flag_7  (expAB_0_7_io_P_flag[1:0]  ), //i
    .io_P_flag_8  (expAB_0_8_io_P_flag[1:0]  ), //i
    .io_P_flag_9  (expAB_0_9_io_P_flag[1:0]  ), //i
    .io_P_flag_10 (expAB_0_10_io_P_flag[1:0] ), //i
    .io_P_flag_11 (expAB_0_11_io_P_flag[1:0] ), //i
    .io_P_flag_12 (expAB_0_12_io_P_flag[1:0] ), //i
    .io_P_flag_13 (expAB_0_13_io_P_flag[1:0] ), //i
    .io_P_flag_14 (expAB_0_14_io_P_flag[1:0] ), //i
    .io_P_flag_15 (expAB_0_15_io_P_flag[1:0] ), //i
    .io_P_flag_16 (pathCInst_io_c_flag_0[1:0]), //i
    .io_P_nrsh_0  (nrshP_0_io_P_nrsh_0[9:0]  ), //o
    .io_P_nrsh_1  (nrshP_0_io_P_nrsh_1[9:0]  ), //o
    .io_P_nrsh_2  (nrshP_0_io_P_nrsh_2[9:0]  ), //o
    .io_P_nrsh_3  (nrshP_0_io_P_nrsh_3[9:0]  ), //o
    .io_P_nrsh_4  (nrshP_0_io_P_nrsh_4[9:0]  ), //o
    .io_P_nrsh_5  (nrshP_0_io_P_nrsh_5[9:0]  ), //o
    .io_P_nrsh_6  (nrshP_0_io_P_nrsh_6[9:0]  ), //o
    .io_P_nrsh_7  (nrshP_0_io_P_nrsh_7[9:0]  ), //o
    .io_P_nrsh_8  (nrshP_0_io_P_nrsh_8[9:0]  ), //o
    .io_P_nrsh_9  (nrshP_0_io_P_nrsh_9[9:0]  ), //o
    .io_P_nrsh_10 (nrshP_0_io_P_nrsh_10[9:0] ), //o
    .io_P_nrsh_11 (nrshP_0_io_P_nrsh_11[9:0] ), //o
    .io_P_nrsh_12 (nrshP_0_io_P_nrsh_12[9:0] ), //o
    .io_P_nrsh_13 (nrshP_0_io_P_nrsh_13[9:0] ), //o
    .io_P_nrsh_14 (nrshP_0_io_P_nrsh_14[9:0] ), //o
    .io_P_nrsh_15 (nrshP_0_io_P_nrsh_15[9:0] ), //o
    .io_P_nrsh_16 (nrshP_0_io_P_nrsh_16[9:0] ), //o
    .io_Q_expn    (nrshP_0_io_Q_expn[9:0]    ), //o
    .io_Q_sign    (nrshP_0_io_Q_sign         ), //o
    .io_Q_flag    (nrshP_0_io_Q_flag[1:0]    ), //o
    .clk          (clk                       ), //i
    .resetn       (resetn                    )  //i
  );
  nrshUnit nrshP_1 (
    .io_P_expn_0  (expAB_1_0_io_P_expn[9:0]  ), //i
    .io_P_expn_1  (expAB_1_1_io_P_expn[9:0]  ), //i
    .io_P_expn_2  (expAB_1_2_io_P_expn[9:0]  ), //i
    .io_P_expn_3  (expAB_1_3_io_P_expn[9:0]  ), //i
    .io_P_expn_4  (expAB_1_4_io_P_expn[9:0]  ), //i
    .io_P_expn_5  (expAB_1_5_io_P_expn[9:0]  ), //i
    .io_P_expn_6  (expAB_1_6_io_P_expn[9:0]  ), //i
    .io_P_expn_7  (expAB_1_7_io_P_expn[9:0]  ), //i
    .io_P_expn_8  (expAB_1_8_io_P_expn[9:0]  ), //i
    .io_P_expn_9  (expAB_1_9_io_P_expn[9:0]  ), //i
    .io_P_expn_10 (expAB_1_10_io_P_expn[9:0] ), //i
    .io_P_expn_11 (expAB_1_11_io_P_expn[9:0] ), //i
    .io_P_expn_12 (expAB_1_12_io_P_expn[9:0] ), //i
    .io_P_expn_13 (expAB_1_13_io_P_expn[9:0] ), //i
    .io_P_expn_14 (expAB_1_14_io_P_expn[9:0] ), //i
    .io_P_expn_15 (expAB_1_15_io_P_expn[9:0] ), //i
    .io_P_expn_16 (pathCInst_io_c_expn_1[9:0]), //i
    .io_P_sign_0  (expAB_1_0_io_P_sign       ), //i
    .io_P_sign_1  (expAB_1_1_io_P_sign       ), //i
    .io_P_sign_2  (expAB_1_2_io_P_sign       ), //i
    .io_P_sign_3  (expAB_1_3_io_P_sign       ), //i
    .io_P_sign_4  (expAB_1_4_io_P_sign       ), //i
    .io_P_sign_5  (expAB_1_5_io_P_sign       ), //i
    .io_P_sign_6  (expAB_1_6_io_P_sign       ), //i
    .io_P_sign_7  (expAB_1_7_io_P_sign       ), //i
    .io_P_sign_8  (expAB_1_8_io_P_sign       ), //i
    .io_P_sign_9  (expAB_1_9_io_P_sign       ), //i
    .io_P_sign_10 (expAB_1_10_io_P_sign      ), //i
    .io_P_sign_11 (expAB_1_11_io_P_sign      ), //i
    .io_P_sign_12 (expAB_1_12_io_P_sign      ), //i
    .io_P_sign_13 (expAB_1_13_io_P_sign      ), //i
    .io_P_sign_14 (expAB_1_14_io_P_sign      ), //i
    .io_P_sign_15 (expAB_1_15_io_P_sign      ), //i
    .io_P_sign_16 (pathCInst_io_c_sign_1     ), //i
    .io_P_flag_0  (expAB_1_0_io_P_flag[1:0]  ), //i
    .io_P_flag_1  (expAB_1_1_io_P_flag[1:0]  ), //i
    .io_P_flag_2  (expAB_1_2_io_P_flag[1:0]  ), //i
    .io_P_flag_3  (expAB_1_3_io_P_flag[1:0]  ), //i
    .io_P_flag_4  (expAB_1_4_io_P_flag[1:0]  ), //i
    .io_P_flag_5  (expAB_1_5_io_P_flag[1:0]  ), //i
    .io_P_flag_6  (expAB_1_6_io_P_flag[1:0]  ), //i
    .io_P_flag_7  (expAB_1_7_io_P_flag[1:0]  ), //i
    .io_P_flag_8  (expAB_1_8_io_P_flag[1:0]  ), //i
    .io_P_flag_9  (expAB_1_9_io_P_flag[1:0]  ), //i
    .io_P_flag_10 (expAB_1_10_io_P_flag[1:0] ), //i
    .io_P_flag_11 (expAB_1_11_io_P_flag[1:0] ), //i
    .io_P_flag_12 (expAB_1_12_io_P_flag[1:0] ), //i
    .io_P_flag_13 (expAB_1_13_io_P_flag[1:0] ), //i
    .io_P_flag_14 (expAB_1_14_io_P_flag[1:0] ), //i
    .io_P_flag_15 (expAB_1_15_io_P_flag[1:0] ), //i
    .io_P_flag_16 (pathCInst_io_c_flag_1[1:0]), //i
    .io_P_nrsh_0  (nrshP_1_io_P_nrsh_0[9:0]  ), //o
    .io_P_nrsh_1  (nrshP_1_io_P_nrsh_1[9:0]  ), //o
    .io_P_nrsh_2  (nrshP_1_io_P_nrsh_2[9:0]  ), //o
    .io_P_nrsh_3  (nrshP_1_io_P_nrsh_3[9:0]  ), //o
    .io_P_nrsh_4  (nrshP_1_io_P_nrsh_4[9:0]  ), //o
    .io_P_nrsh_5  (nrshP_1_io_P_nrsh_5[9:0]  ), //o
    .io_P_nrsh_6  (nrshP_1_io_P_nrsh_6[9:0]  ), //o
    .io_P_nrsh_7  (nrshP_1_io_P_nrsh_7[9:0]  ), //o
    .io_P_nrsh_8  (nrshP_1_io_P_nrsh_8[9:0]  ), //o
    .io_P_nrsh_9  (nrshP_1_io_P_nrsh_9[9:0]  ), //o
    .io_P_nrsh_10 (nrshP_1_io_P_nrsh_10[9:0] ), //o
    .io_P_nrsh_11 (nrshP_1_io_P_nrsh_11[9:0] ), //o
    .io_P_nrsh_12 (nrshP_1_io_P_nrsh_12[9:0] ), //o
    .io_P_nrsh_13 (nrshP_1_io_P_nrsh_13[9:0] ), //o
    .io_P_nrsh_14 (nrshP_1_io_P_nrsh_14[9:0] ), //o
    .io_P_nrsh_15 (nrshP_1_io_P_nrsh_15[9:0] ), //o
    .io_P_nrsh_16 (nrshP_1_io_P_nrsh_16[9:0] ), //o
    .io_Q_expn    (nrshP_1_io_Q_expn[9:0]    ), //o
    .io_Q_sign    (nrshP_1_io_Q_sign         ), //o
    .io_Q_flag    (nrshP_1_io_Q_flag[1:0]    ), //o
    .clk          (clk                       ), //i
    .resetn       (resetn                    )  //i
  );
  FPalignUnit alignerFP_P_0_0 (
    .io_i_sel  (alignerFP_P_0_0_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_0_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3              ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_0[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_0_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_1 (
    .io_i_sel  (alignerFP_P_0_1_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_1_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_2            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_1[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_1_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_2 (
    .io_i_sel  (alignerFP_P_0_2_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_2_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_4            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_2[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_2_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_3 (
    .io_i_sel  (alignerFP_P_0_3_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_3_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_6            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_3[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_3_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_4 (
    .io_i_sel  (alignerFP_P_0_4_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_4_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_8            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_4[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_4_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_5 (
    .io_i_sel  (alignerFP_P_0_5_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_5_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_10           ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_5[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_5_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_6 (
    .io_i_sel  (alignerFP_P_0_6_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_6_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_12           ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_6[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_6_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_7 (
    .io_i_sel  (alignerFP_P_0_7_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_7_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_14           ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_7[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_7_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_8 (
    .io_i_sel  (alignerFP_P_0_8_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_8_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_16           ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_8[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_8_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_9 (
    .io_i_sel  (alignerFP_P_0_9_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_9_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_18           ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_9[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_9_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_0_10 (
    .io_i_sel  (alignerFP_P_0_10_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_10_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_20            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_10[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_10_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_0_11 (
    .io_i_sel  (alignerFP_P_0_11_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_11_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_22            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_11[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_11_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_0_12 (
    .io_i_sel  (alignerFP_P_0_12_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_12_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_24            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_12[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_12_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_0_13 (
    .io_i_sel  (alignerFP_P_0_13_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_13_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_26            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_13[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_13_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_0_14 (
    .io_i_sel  (alignerFP_P_0_14_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_14_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_28            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_14[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_14_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_0_15 (
    .io_i_sel  (alignerFP_P_0_15_io_i_sel       ), //i
    .io_i_mtsa (alignerFP_P_0_15_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_30            ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_15[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_0_15_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_1_0 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_0_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_1            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_0[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_0_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_1 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_1_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_3            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_1[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_1_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_2 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_2_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_5            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_2[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_2_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_3 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_3_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_7            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_3[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_3_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_4 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_4_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_9            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_4[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_4_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_5 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_5_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_11           ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_5[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_5_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_6 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_6_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_13           ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_6[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_6_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_7 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_7_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_15           ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_7[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_7_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_8 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_8_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_17           ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_8[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_8_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_9 (
    .io_i_sel  (1'b1                           ), //i
    .io_i_mtsa (alignerFP_P_1_9_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_19           ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_9[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_9_io_o_mtsa[55:0]), //o
    .clk       (clk                            ), //i
    .resetn    (resetn                         )  //i
  );
  FPalignUnit alignerFP_P_1_10 (
    .io_i_sel  (1'b1                            ), //i
    .io_i_mtsa (alignerFP_P_1_10_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_21            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_10[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_10_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_1_11 (
    .io_i_sel  (1'b1                            ), //i
    .io_i_mtsa (alignerFP_P_1_11_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_23            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_11[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_11_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_1_12 (
    .io_i_sel  (1'b1                            ), //i
    .io_i_mtsa (alignerFP_P_1_12_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_25            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_12[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_12_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_1_13 (
    .io_i_sel  (1'b1                            ), //i
    .io_i_mtsa (alignerFP_P_1_13_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_27            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_13[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_13_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_1_14 (
    .io_i_sel  (1'b1                            ), //i
    .io_i_mtsa (alignerFP_P_1_14_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_29            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_14[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_14_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit alignerFP_P_1_15 (
    .io_i_sel  (1'b1                            ), //i
    .io_i_mtsa (alignerFP_P_1_15_io_i_mtsa[47:0]), //i
    .io_i_sign (io_P_sign_delay_3_31            ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_15[9:0]       ), //i
    .io_o_mtsa (alignerFP_P_1_15_io_o_mtsa[55:0]), //o
    .clk       (clk                             ), //i
    .resetn    (resetn                          )  //i
  );
  FPalignUnit_32 alignerFP_C_0 (
    .io_i_sel  (alignerFP_C_0_io_i_sel       ), //i
    .io_i_mtsa (io_c_mtsa_0_delay_3[23:0]    ), //i
    .io_i_sign (io_c_sign_0_delay_3          ), //i
    .io_i_nrsh (nrshP_0_io_P_nrsh_16[9:0]    ), //i
    .io_o_mtsa (alignerFP_C_0_io_o_mtsa[55:0]), //o
    .clk       (clk                          ), //i
    .resetn    (resetn                       )  //i
  );
  FPalignUnit_32 alignerFP_C_1 (
    .io_i_sel  (alignerFP_C_1_io_i_sel       ), //i
    .io_i_mtsa (io_c_mtsa_1_delay_3[23:0]    ), //i
    .io_i_sign (io_c_sign_1_delay_3          ), //i
    .io_i_nrsh (nrshP_1_io_P_nrsh_16[9:0]    ), //i
    .io_o_mtsa (alignerFP_C_1_io_o_mtsa[55:0]), //o
    .clk       (clk                          ), //i
    .resetn    (resetn                       )  //i
  );
  adderTree addTreeInst_0 (
    .io_i_data_0  (addTreeInst_0_io_i_data_0[55:0] ), //i
    .io_i_data_1  (addTreeInst_0_io_i_data_1[55:0] ), //i
    .io_i_data_2  (addTreeInst_0_io_i_data_2[55:0] ), //i
    .io_i_data_3  (addTreeInst_0_io_i_data_3[55:0] ), //i
    .io_i_data_4  (addTreeInst_0_io_i_data_4[55:0] ), //i
    .io_i_data_5  (addTreeInst_0_io_i_data_5[55:0] ), //i
    .io_i_data_6  (addTreeInst_0_io_i_data_6[55:0] ), //i
    .io_i_data_7  (addTreeInst_0_io_i_data_7[55:0] ), //i
    .io_i_data_8  (addTreeInst_0_io_i_data_8[55:0] ), //i
    .io_i_data_9  (addTreeInst_0_io_i_data_9[55:0] ), //i
    .io_i_data_10 (addTreeInst_0_io_i_data_10[55:0]), //i
    .io_i_data_11 (addTreeInst_0_io_i_data_11[55:0]), //i
    .io_i_data_12 (addTreeInst_0_io_i_data_12[55:0]), //i
    .io_i_data_13 (addTreeInst_0_io_i_data_13[55:0]), //i
    .io_i_data_14 (addTreeInst_0_io_i_data_14[55:0]), //i
    .io_i_data_15 (addTreeInst_0_io_i_data_15[55:0]), //i
    .io_i_data_16 (addTreeInst_0_io_i_data_16[55:0]), //i
    .io_o_data    (addTreeInst_0_io_o_data[55:0]   ), //o
    .clk          (clk                             ), //i
    .resetn       (resetn                          )  //i
  );
  adderTree addTreeInst_1 (
    .io_i_data_0  (addTreeInst_1_io_i_data_0[55:0] ), //i
    .io_i_data_1  (addTreeInst_1_io_i_data_1[55:0] ), //i
    .io_i_data_2  (addTreeInst_1_io_i_data_2[55:0] ), //i
    .io_i_data_3  (addTreeInst_1_io_i_data_3[55:0] ), //i
    .io_i_data_4  (addTreeInst_1_io_i_data_4[55:0] ), //i
    .io_i_data_5  (addTreeInst_1_io_i_data_5[55:0] ), //i
    .io_i_data_6  (addTreeInst_1_io_i_data_6[55:0] ), //i
    .io_i_data_7  (addTreeInst_1_io_i_data_7[55:0] ), //i
    .io_i_data_8  (addTreeInst_1_io_i_data_8[55:0] ), //i
    .io_i_data_9  (addTreeInst_1_io_i_data_9[55:0] ), //i
    .io_i_data_10 (addTreeInst_1_io_i_data_10[55:0]), //i
    .io_i_data_11 (addTreeInst_1_io_i_data_11[55:0]), //i
    .io_i_data_12 (addTreeInst_1_io_i_data_12[55:0]), //i
    .io_i_data_13 (addTreeInst_1_io_i_data_13[55:0]), //i
    .io_i_data_14 (addTreeInst_1_io_i_data_14[55:0]), //i
    .io_i_data_15 (addTreeInst_1_io_i_data_15[55:0]), //i
    .io_i_data_16 (addTreeInst_1_io_i_data_16[55:0]), //i
    .io_o_data    (addTreeInst_1_io_o_data[55:0]   ), //o
    .clk          (clk                             ), //i
    .resetn       (resetn                          )  //i
  );
  normRoundUnit roundInst_0 (
    .io_i_sel  (roundInst_0_io_i_sel         ), //i
    .io_i_mtsa (addTreeInst_0_io_o_data[55:0]), //i
    .io_i_expn (io_Q_expn_delay_5[9:0]       ), //i
    .io_i_sign (io_Q_sign_delay_5            ), //i
    .io_i_flag (io_Q_flag_delay_5[1:0]       ), //i
    .io_o_mtsa (roundInst_0_io_o_mtsa[23:0]  ), //o
    .io_o_expn (roundInst_0_io_o_expn[9:0]   ), //o
    .io_o_sign (roundInst_0_io_o_sign        ), //o
    .io_o_flag (roundInst_0_io_o_flag[1:0]   ), //o
    .clk       (clk                          ), //i
    .resetn    (resetn                       )  //i
  );
  normRoundUnit roundInst_1 (
    .io_i_sel  (roundInst_1_io_i_sel         ), //i
    .io_i_mtsa (addTreeInst_1_io_o_data[55:0]), //i
    .io_i_expn (io_Q_expn_delay_5_1[9:0]     ), //i
    .io_i_sign (io_Q_sign_delay_5_1          ), //i
    .io_i_flag (io_Q_flag_delay_5_1[1:0]     ), //i
    .io_o_mtsa (roundInst_1_io_o_mtsa[23:0]  ), //o
    .io_o_expn (roundInst_1_io_o_expn[9:0]   ), //o
    .io_o_sign (roundInst_1_io_o_sign        ), //o
    .io_o_flag (roundInst_1_io_o_flag[1:0]   ), //o
    .clk       (clk                          ), //i
    .resetn    (resetn                       )  //i
  );
  packUnit packer_0 (
    .io_op    (CDpackMode[1:0]            ), //i
    .io_mtsa  (roundInst_0_io_o_mtsa[23:0]), //i
    .io_expn  (roundInst_0_io_o_expn[9:0] ), //i
    .io_sign  (roundInst_0_io_o_sign      ), //i
    .io_flag  (roundInst_0_io_o_flag[1:0] ), //i
    .io_pack  (packer_0_io_pack[31:0]     ), //o
    .io_isNaN (packer_0_io_isNaN          ), //o
    .io_isInf (packer_0_io_isInf          ), //o
    .clk      (clk                        ), //i
    .resetn   (resetn                     )  //i
  );
  packUnit packer_1 (
    .io_op    (CDpackMode[1:0]            ), //i
    .io_mtsa  (roundInst_1_io_o_mtsa[23:0]), //i
    .io_expn  (roundInst_1_io_o_expn[9:0] ), //i
    .io_sign  (roundInst_1_io_o_sign      ), //i
    .io_flag  (roundInst_1_io_o_flag[1:0] ), //i
    .io_pack  (packer_1_io_pack[31:0]     ), //o
    .io_isNaN (packer_1_io_isNaN          ), //o
    .io_isInf (packer_1_io_isInf          ), //o
    .clk      (clk                        ), //i
    .resetn   (resetn                     )  //i
  );
  FPalignUnit fPalignUnit_40 (
    .io_i_sel  (                              ), //i
    .io_i_mtsa (                              ), //i
    .io_i_sign (                              ), //i
    .io_i_nrsh (                              ), //i
    .io_o_mtsa (fPalignUnit_40_io_o_mtsa[55:0]), //o
    .clk       (clk                           ), //i
    .resetn    (resetn                        )  //i
  );
  adderTree adderTree_8 (
    .io_i_data_0  (                           ), //i
    .io_i_data_1  (                           ), //i
    .io_i_data_2  (                           ), //i
    .io_i_data_3  (                           ), //i
    .io_i_data_4  (                           ), //i
    .io_i_data_5  (                           ), //i
    .io_i_data_6  (                           ), //i
    .io_i_data_7  (                           ), //i
    .io_i_data_8  (                           ), //i
    .io_i_data_9  (                           ), //i
    .io_i_data_10 (                           ), //i
    .io_i_data_11 (                           ), //i
    .io_i_data_12 (                           ), //i
    .io_i_data_13 (                           ), //i
    .io_i_data_14 (                           ), //i
    .io_i_data_15 (                           ), //i
    .io_i_data_16 (                           ), //i
    .io_o_data    (adderTree_8_io_o_data[55:0]), //o
    .clk          (clk                        ), //i
    .resetn       (resetn                     )  //i
  );
  FPalignUnit fPalignUnit_41 (
    .io_i_sel  (                              ), //i
    .io_i_mtsa (                              ), //i
    .io_i_sign (                              ), //i
    .io_i_nrsh (                              ), //i
    .io_o_mtsa (fPalignUnit_41_io_o_mtsa[55:0]), //o
    .clk       (clk                           ), //i
    .resetn    (resetn                        )  //i
  );
  adderTree adderTree_9 (
    .io_i_data_0  (                           ), //i
    .io_i_data_1  (                           ), //i
    .io_i_data_2  (                           ), //i
    .io_i_data_3  (                           ), //i
    .io_i_data_4  (                           ), //i
    .io_i_data_5  (                           ), //i
    .io_i_data_6  (                           ), //i
    .io_i_data_7  (                           ), //i
    .io_i_data_8  (                           ), //i
    .io_i_data_9  (                           ), //i
    .io_i_data_10 (                           ), //i
    .io_i_data_11 (                           ), //i
    .io_i_data_12 (                           ), //i
    .io_i_data_13 (                           ), //i
    .io_i_data_14 (                           ), //i
    .io_i_data_15 (                           ), //i
    .io_i_data_16 (                           ), //i
    .io_o_data    (adderTree_9_io_o_data[55:0]), //o
    .clk          (clk                        ), //i
    .resetn       (resetn                     )  //i
  );
  FPalignUnit fPalignUnit_42 (
    .io_i_sel  (                              ), //i
    .io_i_mtsa (                              ), //i
    .io_i_sign (                              ), //i
    .io_i_nrsh (                              ), //i
    .io_o_mtsa (fPalignUnit_42_io_o_mtsa[55:0]), //o
    .clk       (clk                           ), //i
    .resetn    (resetn                        )  //i
  );
  adderTree adderTree_10 (
    .io_i_data_0  (                            ), //i
    .io_i_data_1  (                            ), //i
    .io_i_data_2  (                            ), //i
    .io_i_data_3  (                            ), //i
    .io_i_data_4  (                            ), //i
    .io_i_data_5  (                            ), //i
    .io_i_data_6  (                            ), //i
    .io_i_data_7  (                            ), //i
    .io_i_data_8  (                            ), //i
    .io_i_data_9  (                            ), //i
    .io_i_data_10 (                            ), //i
    .io_i_data_11 (                            ), //i
    .io_i_data_12 (                            ), //i
    .io_i_data_13 (                            ), //i
    .io_i_data_14 (                            ), //i
    .io_i_data_15 (                            ), //i
    .io_i_data_16 (                            ), //i
    .io_o_data    (adderTree_10_io_o_data[55:0]), //o
    .clk          (clk                         ), //i
    .resetn       (resetn                      )  //i
  );
  FPalignUnit fPalignUnit_43 (
    .io_i_sel  (                              ), //i
    .io_i_mtsa (                              ), //i
    .io_i_sign (                              ), //i
    .io_i_nrsh (                              ), //i
    .io_o_mtsa (fPalignUnit_43_io_o_mtsa[55:0]), //o
    .clk       (clk                           ), //i
    .resetn    (resetn                        )  //i
  );
  adderTree adderTree_11 (
    .io_i_data_0  (                            ), //i
    .io_i_data_1  (                            ), //i
    .io_i_data_2  (                            ), //i
    .io_i_data_3  (                            ), //i
    .io_i_data_4  (                            ), //i
    .io_i_data_5  (                            ), //i
    .io_i_data_6  (                            ), //i
    .io_i_data_7  (                            ), //i
    .io_i_data_8  (                            ), //i
    .io_i_data_9  (                            ), //i
    .io_i_data_10 (                            ), //i
    .io_i_data_11 (                            ), //i
    .io_i_data_12 (                            ), //i
    .io_i_data_13 (                            ), //i
    .io_i_data_14 (                            ), //i
    .io_i_data_15 (                            ), //i
    .io_i_data_16 (                            ), //i
    .io_o_data    (adderTree_11_io_o_data[55:0]), //o
    .clk          (clk                         ), //i
    .resetn       (resetn                      )  //i
  );
  FPalignUnit fPalignUnit_44 (
    .io_i_sel  (                              ), //i
    .io_i_mtsa (                              ), //i
    .io_i_sign (                              ), //i
    .io_i_nrsh (                              ), //i
    .io_o_mtsa (fPalignUnit_44_io_o_mtsa[55:0]), //o
    .clk       (clk                           ), //i
    .resetn    (resetn                        )  //i
  );
  adderTree adderTree_12 (
    .io_i_data_0  (                            ), //i
    .io_i_data_1  (                            ), //i
    .io_i_data_2  (                            ), //i
    .io_i_data_3  (                            ), //i
    .io_i_data_4  (                            ), //i
    .io_i_data_5  (                            ), //i
    .io_i_data_6  (                            ), //i
    .io_i_data_7  (                            ), //i
    .io_i_data_8  (                            ), //i
    .io_i_data_9  (                            ), //i
    .io_i_data_10 (                            ), //i
    .io_i_data_11 (                            ), //i
    .io_i_data_12 (                            ), //i
    .io_i_data_13 (                            ), //i
    .io_i_data_14 (                            ), //i
    .io_i_data_15 (                            ), //i
    .io_i_data_16 (                            ), //i
    .io_o_data    (adderTree_12_io_o_data[55:0]), //o
    .clk          (clk                         ), //i
    .resetn       (resetn                      )  //i
  );
  FPalignUnit fPalignUnit_45 (
    .io_i_sel  (                              ), //i
    .io_i_mtsa (                              ), //i
    .io_i_sign (                              ), //i
    .io_i_nrsh (                              ), //i
    .io_o_mtsa (fPalignUnit_45_io_o_mtsa[55:0]), //o
    .clk       (clk                           ), //i
    .resetn    (resetn                        )  //i
  );
  adderTree adderTree_13 (
    .io_i_data_0  (                            ), //i
    .io_i_data_1  (                            ), //i
    .io_i_data_2  (                            ), //i
    .io_i_data_3  (                            ), //i
    .io_i_data_4  (                            ), //i
    .io_i_data_5  (                            ), //i
    .io_i_data_6  (                            ), //i
    .io_i_data_7  (                            ), //i
    .io_i_data_8  (                            ), //i
    .io_i_data_9  (                            ), //i
    .io_i_data_10 (                            ), //i
    .io_i_data_11 (                            ), //i
    .io_i_data_12 (                            ), //i
    .io_i_data_13 (                            ), //i
    .io_i_data_14 (                            ), //i
    .io_i_data_15 (                            ), //i
    .io_i_data_16 (                            ), //i
    .io_o_data    (adderTree_13_io_o_data[55:0]), //o
    .clk          (clk                         ), //i
    .resetn       (resetn                      )  //i
  );
  intAdderChecker intAdder_0 (
    .io_i_C (_zz_io_i_C_8[31:0]     ), //i
    .io_i_Q (intAdder_0_io_i_Q[21:0]), //i
    .io_o_D (intAdder_0_io_o_D[31:0]), //o
    .io_ovf (intAdder_0_io_ovf      ), //o
    .clk    (clk                    ), //i
    .resetn (resetn                 )  //i
  );
  intAdderChecker intAdder_1 (
    .io_i_C (_zz_io_i_C_17[31:0]    ), //i
    .io_i_Q (intAdder_1_io_i_Q[21:0]), //i
    .io_o_D (intAdder_1_io_o_D[31:0]), //o
    .io_ovf (intAdder_1_io_ovf      ), //o
    .clk    (clk                    ), //i
    .resetn (resetn                 )  //i
  );
  intAdderChecker intAdder_2 (
    .io_i_C (_zz_io_i_C_26[31:0]    ), //i
    .io_i_Q (intAdder_2_io_i_Q[21:0]), //i
    .io_o_D (intAdder_2_io_o_D[31:0]), //o
    .io_ovf (intAdder_2_io_ovf      ), //o
    .clk    (clk                    ), //i
    .resetn (resetn                 )  //i
  );
  intAdderChecker intAdder_3 (
    .io_i_C (_zz_io_i_C_35[31:0]    ), //i
    .io_i_Q (intAdder_3_io_i_Q[21:0]), //i
    .io_o_D (intAdder_3_io_o_D[31:0]), //o
    .io_ovf (intAdder_3_io_ovf      ), //o
    .clk    (clk                    ), //i
    .resetn (resetn                 )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      ArithOp_FP32 : io_op_string = "FP32    ";
      ArithOp_FP16 : io_op_string = "FP16    ";
      ArithOp_FP16_MIX : io_op_string = "FP16_MIX";
      ArithOp_INT8 : io_op_string = "INT8    ";
      ArithOp_INT4 : io_op_string = "INT4    ";
      default : io_op_string = "????????";
    endcase
  end
  always @(*) begin
    case(arithMode)
      ArithOp_FP32 : arithMode_string = "FP32    ";
      ArithOp_FP16 : arithMode_string = "FP16    ";
      ArithOp_FP16_MIX : arithMode_string = "FP16_MIX";
      ArithOp_INT8 : arithMode_string = "INT8    ";
      ArithOp_INT4 : arithMode_string = "INT4    ";
      default : arithMode_string = "????????";
    endcase
  end
  always @(*) begin
    case(ABpackMode)
      PackOp_INTx : ABpackMode_string = "INTx";
      PackOp_FP32 : ABpackMode_string = "FP32";
      PackOp_FP16 : ABpackMode_string = "FP16";
      default : ABpackMode_string = "????";
    endcase
  end
  always @(*) begin
    case(CDpackMode)
      PackOp_INTx : CDpackMode_string = "INTx";
      PackOp_FP32 : CDpackMode_string = "FP32";
      PackOp_FP16 : CDpackMode_string = "FP16";
      default : CDpackMode_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_1)
      FpFlag_ZERO : io_Q_flag_delay_1_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_1_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_1_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_1_string = "NAN ";
      default : io_Q_flag_delay_1_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_2)
      FpFlag_ZERO : io_Q_flag_delay_2_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_2_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_2_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_2_string = "NAN ";
      default : io_Q_flag_delay_2_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_3)
      FpFlag_ZERO : io_Q_flag_delay_3_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_3_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_3_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_3_string = "NAN ";
      default : io_Q_flag_delay_3_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_4)
      FpFlag_ZERO : io_Q_flag_delay_4_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_4_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_4_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_4_string = "NAN ";
      default : io_Q_flag_delay_4_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_5)
      FpFlag_ZERO : io_Q_flag_delay_5_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_5_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_5_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_5_string = "NAN ";
      default : io_Q_flag_delay_5_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_1_1)
      FpFlag_ZERO : io_Q_flag_delay_1_1_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_1_1_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_1_1_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_1_1_string = "NAN ";
      default : io_Q_flag_delay_1_1_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_2_1)
      FpFlag_ZERO : io_Q_flag_delay_2_1_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_2_1_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_2_1_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_2_1_string = "NAN ";
      default : io_Q_flag_delay_2_1_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_3_1)
      FpFlag_ZERO : io_Q_flag_delay_3_1_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_3_1_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_3_1_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_3_1_string = "NAN ";
      default : io_Q_flag_delay_3_1_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_4_1)
      FpFlag_ZERO : io_Q_flag_delay_4_1_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_4_1_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_4_1_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_4_1_string = "NAN ";
      default : io_Q_flag_delay_4_1_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag_delay_5_1)
      FpFlag_ZERO : io_Q_flag_delay_5_1_string = "ZERO";
      FpFlag_NORM : io_Q_flag_delay_5_1_string = "NORM";
      FpFlag_INF : io_Q_flag_delay_5_1_string = "INF ";
      FpFlag_NAN : io_Q_flag_delay_5_1_string = "NAN ";
      default : io_Q_flag_delay_5_1_string = "????";
    endcase
  end
  `endif

  assign isIntMode = ((arithMode == ArithOp_INT4) || (arithMode == ArithOp_INT8));
  assign vecA_0 = io_vecA[31 : 0];
  assign vecA_1 = io_vecA[63 : 32];
  assign vecA_2 = io_vecA[95 : 64];
  assign vecA_3 = io_vecA[127 : 96];
  assign vecA_4 = io_vecA[159 : 128];
  assign vecA_5 = io_vecA[191 : 160];
  assign vecA_6 = io_vecA[223 : 192];
  assign vecA_7 = io_vecA[255 : 224];
  assign vecA_8 = io_vecA[287 : 256];
  assign vecA_9 = io_vecA[319 : 288];
  assign vecA_10 = io_vecA[351 : 320];
  assign vecA_11 = io_vecA[383 : 352];
  assign vecA_12 = io_vecA[415 : 384];
  assign vecA_13 = io_vecA[447 : 416];
  assign vecA_14 = io_vecA[479 : 448];
  assign vecA_15 = io_vecA[511 : 480];
  assign vecB_0 = io_vecB[31 : 0];
  assign vecB_1 = io_vecB[63 : 32];
  assign vecB_2 = io_vecB[95 : 64];
  assign vecB_3 = io_vecB[127 : 96];
  assign vecB_4 = io_vecB[159 : 128];
  assign vecB_5 = io_vecB[191 : 160];
  assign vecB_6 = io_vecB[223 : 192];
  assign vecB_7 = io_vecB[255 : 224];
  assign vecB_8 = io_vecB[287 : 256];
  assign vecB_9 = io_vecB[319 : 288];
  assign vecB_10 = io_vecB[351 : 320];
  assign vecB_11 = io_vecB[383 : 352];
  assign vecB_12 = io_vecB[415 : 384];
  assign vecB_13 = io_vecB[447 : 416];
  assign vecB_14 = io_vecB[479 : 448];
  assign vecB_15 = io_vecB[511 : 480];
  assign vecC_0 = io_vecC[31 : 0];
  assign vecC_1 = io_vecC[63 : 32];
  assign vecC_2 = io_vecC[95 : 64];
  assign vecC_3 = io_vecC[127 : 96];
  assign alignerFP_P_0_0_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_0_io_i_mtsa = mulAB_0_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_0_io_i_mtsa = {24'h0,mulAB_0_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_1_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_1_io_i_mtsa = mulAB_1_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_1_io_i_mtsa = {24'h0,mulAB_1_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_2_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_2_io_i_mtsa = mulAB_2_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_2_io_i_mtsa = {24'h0,mulAB_2_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_3_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_3_io_i_mtsa = mulAB_3_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_3_io_i_mtsa = {24'h0,mulAB_3_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_4_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_4_io_i_mtsa = mulAB_4_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_4_io_i_mtsa = {24'h0,mulAB_4_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_5_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_5_io_i_mtsa = mulAB_5_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_5_io_i_mtsa = {24'h0,mulAB_5_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_6_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_6_io_i_mtsa = mulAB_6_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_6_io_i_mtsa = {24'h0,mulAB_6_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_7_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_7_io_i_mtsa = mulAB_7_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_7_io_i_mtsa = {24'h0,mulAB_7_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_8_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_8_io_i_mtsa = mulAB_8_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_8_io_i_mtsa = {24'h0,mulAB_8_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_9_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_9_io_i_mtsa = mulAB_9_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_9_io_i_mtsa = {24'h0,mulAB_9_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_10_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_10_io_i_mtsa = mulAB_10_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_10_io_i_mtsa = {24'h0,mulAB_10_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_11_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_11_io_i_mtsa = mulAB_11_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_11_io_i_mtsa = {24'h0,mulAB_11_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_12_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_12_io_i_mtsa = mulAB_12_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_12_io_i_mtsa = {24'h0,mulAB_12_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_13_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_13_io_i_mtsa = mulAB_13_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_13_io_i_mtsa = {24'h0,mulAB_13_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_14_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_14_io_i_mtsa = mulAB_14_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_14_io_i_mtsa = {24'h0,mulAB_14_io_P_mtsa[47 : 24]};
  assign alignerFP_P_0_15_io_i_sel = (ABpackMode != PackOp_FP32);
  assign alignerFP_P_0_15_io_i_mtsa = mulAB_15_io_P_mtsa[47 : 0];
  assign alignerFP_P_1_15_io_i_mtsa = {24'h0,mulAB_15_io_P_mtsa[47 : 24]};
  assign alignerFP_C_0_io_i_sel = (CDpackMode != PackOp_FP32);
  assign alignerFP_C_1_io_i_sel = (CDpackMode != PackOp_FP32);
  assign _zz_io_i_data_0 = mulAB_0_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_0_1 = _zz_io_i_data_0[15 : 0];
  assign _zz_io_i_data_0_2 = _zz_io_i_data_0[31 : 16];
  assign addTreeInst_0_io_i_data_0 = (isIntMode ? _zz_io_i_data_0_8 : alignerFP_P_0_0_io_o_mtsa);
  assign _zz_io_i_data_1 = mulAB_1_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_1_1 = _zz_io_i_data_1[15 : 0];
  assign _zz_io_i_data_1_2 = _zz_io_i_data_1[31 : 16];
  assign addTreeInst_0_io_i_data_1 = (isIntMode ? _zz_io_i_data_1_8 : alignerFP_P_0_1_io_o_mtsa);
  assign _zz_io_i_data_2 = mulAB_2_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_2_1 = _zz_io_i_data_2[15 : 0];
  assign _zz_io_i_data_2_2 = _zz_io_i_data_2[31 : 16];
  assign addTreeInst_0_io_i_data_2 = (isIntMode ? _zz_io_i_data_2_8 : alignerFP_P_0_2_io_o_mtsa);
  assign _zz_io_i_data_3 = mulAB_3_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_3_1 = _zz_io_i_data_3[15 : 0];
  assign _zz_io_i_data_3_2 = _zz_io_i_data_3[31 : 16];
  assign addTreeInst_0_io_i_data_3 = (isIntMode ? _zz_io_i_data_3_8 : alignerFP_P_0_3_io_o_mtsa);
  assign _zz_io_i_data_4 = mulAB_4_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_4_1 = _zz_io_i_data_4[15 : 0];
  assign _zz_io_i_data_4_2 = _zz_io_i_data_4[31 : 16];
  assign addTreeInst_0_io_i_data_4 = (isIntMode ? _zz_io_i_data_4_8 : alignerFP_P_0_4_io_o_mtsa);
  assign _zz_io_i_data_5 = mulAB_5_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_5_1 = _zz_io_i_data_5[15 : 0];
  assign _zz_io_i_data_5_2 = _zz_io_i_data_5[31 : 16];
  assign addTreeInst_0_io_i_data_5 = (isIntMode ? _zz_io_i_data_5_8 : alignerFP_P_0_5_io_o_mtsa);
  assign _zz_io_i_data_6 = mulAB_6_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_6_1 = _zz_io_i_data_6[15 : 0];
  assign _zz_io_i_data_6_2 = _zz_io_i_data_6[31 : 16];
  assign addTreeInst_0_io_i_data_6 = (isIntMode ? _zz_io_i_data_6_8 : alignerFP_P_0_6_io_o_mtsa);
  assign _zz_io_i_data_7 = mulAB_7_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_7_1 = _zz_io_i_data_7[15 : 0];
  assign _zz_io_i_data_7_2 = _zz_io_i_data_7[31 : 16];
  assign addTreeInst_0_io_i_data_7 = (isIntMode ? _zz_io_i_data_7_8 : alignerFP_P_0_7_io_o_mtsa);
  assign _zz_io_i_data_8 = mulAB_8_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_8_1 = _zz_io_i_data_8[15 : 0];
  assign _zz_io_i_data_8_2 = _zz_io_i_data_8[31 : 16];
  assign addTreeInst_0_io_i_data_8 = (isIntMode ? _zz_io_i_data_8_8 : alignerFP_P_0_8_io_o_mtsa);
  assign _zz_io_i_data_9 = mulAB_9_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_9_1 = _zz_io_i_data_9[15 : 0];
  assign _zz_io_i_data_9_2 = _zz_io_i_data_9[31 : 16];
  assign addTreeInst_0_io_i_data_9 = (isIntMode ? _zz_io_i_data_9_8 : alignerFP_P_0_9_io_o_mtsa);
  assign _zz_io_i_data_10 = mulAB_10_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_10_1 = _zz_io_i_data_10[15 : 0];
  assign _zz_io_i_data_10_2 = _zz_io_i_data_10[31 : 16];
  assign addTreeInst_0_io_i_data_10 = (isIntMode ? _zz_io_i_data_10_8 : alignerFP_P_0_10_io_o_mtsa);
  assign _zz_io_i_data_11 = mulAB_11_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_11_1 = _zz_io_i_data_11[15 : 0];
  assign _zz_io_i_data_11_2 = _zz_io_i_data_11[31 : 16];
  assign addTreeInst_0_io_i_data_11 = (isIntMode ? _zz_io_i_data_11_8 : alignerFP_P_0_11_io_o_mtsa);
  assign _zz_io_i_data_12 = mulAB_12_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_12_1 = _zz_io_i_data_12[15 : 0];
  assign _zz_io_i_data_12_2 = _zz_io_i_data_12[31 : 16];
  assign addTreeInst_0_io_i_data_12 = (isIntMode ? _zz_io_i_data_12_8 : alignerFP_P_0_12_io_o_mtsa);
  assign _zz_io_i_data_13 = mulAB_13_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_13_1 = _zz_io_i_data_13[15 : 0];
  assign _zz_io_i_data_13_2 = _zz_io_i_data_13[31 : 16];
  assign addTreeInst_0_io_i_data_13 = (isIntMode ? _zz_io_i_data_13_8 : alignerFP_P_0_13_io_o_mtsa);
  assign _zz_io_i_data_14 = mulAB_14_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_14_1 = _zz_io_i_data_14[15 : 0];
  assign _zz_io_i_data_14_2 = _zz_io_i_data_14[31 : 16];
  assign addTreeInst_0_io_i_data_14 = (isIntMode ? _zz_io_i_data_14_8 : alignerFP_P_0_14_io_o_mtsa);
  assign _zz_io_i_data_15 = mulAB_15_io_P_mtsa[31 : 0];
  assign _zz_io_i_data_15_1 = _zz_io_i_data_15[15 : 0];
  assign _zz_io_i_data_15_2 = _zz_io_i_data_15[31 : 16];
  assign addTreeInst_0_io_i_data_15 = (isIntMode ? _zz_io_i_data_15_8 : alignerFP_P_0_15_io_o_mtsa);
  assign addTreeInst_0_io_i_data_16 = (isIntMode ? 56'h0 : alignerFP_C_0_io_o_mtsa);
  assign _zz_io_i_data_0_4 = mulAB_0_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_0_5 = _zz_io_i_data_0_4[15 : 0];
  assign _zz_io_i_data_0_6 = _zz_io_i_data_0_4[31 : 16];
  assign addTreeInst_1_io_i_data_0 = (isIntMode ? _zz_io_i_data_0_9 : alignerFP_P_1_0_io_o_mtsa);
  assign _zz_io_i_data_1_4 = mulAB_1_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_1_5 = _zz_io_i_data_1_4[15 : 0];
  assign _zz_io_i_data_1_6 = _zz_io_i_data_1_4[31 : 16];
  assign addTreeInst_1_io_i_data_1 = (isIntMode ? _zz_io_i_data_1_9 : alignerFP_P_1_1_io_o_mtsa);
  assign _zz_io_i_data_2_4 = mulAB_2_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_2_5 = _zz_io_i_data_2_4[15 : 0];
  assign _zz_io_i_data_2_6 = _zz_io_i_data_2_4[31 : 16];
  assign addTreeInst_1_io_i_data_2 = (isIntMode ? _zz_io_i_data_2_9 : alignerFP_P_1_2_io_o_mtsa);
  assign _zz_io_i_data_3_4 = mulAB_3_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_3_5 = _zz_io_i_data_3_4[15 : 0];
  assign _zz_io_i_data_3_6 = _zz_io_i_data_3_4[31 : 16];
  assign addTreeInst_1_io_i_data_3 = (isIntMode ? _zz_io_i_data_3_9 : alignerFP_P_1_3_io_o_mtsa);
  assign _zz_io_i_data_4_4 = mulAB_4_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_4_5 = _zz_io_i_data_4_4[15 : 0];
  assign _zz_io_i_data_4_6 = _zz_io_i_data_4_4[31 : 16];
  assign addTreeInst_1_io_i_data_4 = (isIntMode ? _zz_io_i_data_4_9 : alignerFP_P_1_4_io_o_mtsa);
  assign _zz_io_i_data_5_4 = mulAB_5_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_5_5 = _zz_io_i_data_5_4[15 : 0];
  assign _zz_io_i_data_5_6 = _zz_io_i_data_5_4[31 : 16];
  assign addTreeInst_1_io_i_data_5 = (isIntMode ? _zz_io_i_data_5_9 : alignerFP_P_1_5_io_o_mtsa);
  assign _zz_io_i_data_6_4 = mulAB_6_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_6_5 = _zz_io_i_data_6_4[15 : 0];
  assign _zz_io_i_data_6_6 = _zz_io_i_data_6_4[31 : 16];
  assign addTreeInst_1_io_i_data_6 = (isIntMode ? _zz_io_i_data_6_9 : alignerFP_P_1_6_io_o_mtsa);
  assign _zz_io_i_data_7_4 = mulAB_7_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_7_5 = _zz_io_i_data_7_4[15 : 0];
  assign _zz_io_i_data_7_6 = _zz_io_i_data_7_4[31 : 16];
  assign addTreeInst_1_io_i_data_7 = (isIntMode ? _zz_io_i_data_7_9 : alignerFP_P_1_7_io_o_mtsa);
  assign _zz_io_i_data_8_4 = mulAB_8_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_8_5 = _zz_io_i_data_8_4[15 : 0];
  assign _zz_io_i_data_8_6 = _zz_io_i_data_8_4[31 : 16];
  assign addTreeInst_1_io_i_data_8 = (isIntMode ? _zz_io_i_data_8_9 : alignerFP_P_1_8_io_o_mtsa);
  assign _zz_io_i_data_9_4 = mulAB_9_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_9_5 = _zz_io_i_data_9_4[15 : 0];
  assign _zz_io_i_data_9_6 = _zz_io_i_data_9_4[31 : 16];
  assign addTreeInst_1_io_i_data_9 = (isIntMode ? _zz_io_i_data_9_9 : alignerFP_P_1_9_io_o_mtsa);
  assign _zz_io_i_data_10_4 = mulAB_10_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_10_5 = _zz_io_i_data_10_4[15 : 0];
  assign _zz_io_i_data_10_6 = _zz_io_i_data_10_4[31 : 16];
  assign addTreeInst_1_io_i_data_10 = (isIntMode ? _zz_io_i_data_10_9 : alignerFP_P_1_10_io_o_mtsa);
  assign _zz_io_i_data_11_4 = mulAB_11_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_11_5 = _zz_io_i_data_11_4[15 : 0];
  assign _zz_io_i_data_11_6 = _zz_io_i_data_11_4[31 : 16];
  assign addTreeInst_1_io_i_data_11 = (isIntMode ? _zz_io_i_data_11_9 : alignerFP_P_1_11_io_o_mtsa);
  assign _zz_io_i_data_12_4 = mulAB_12_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_12_5 = _zz_io_i_data_12_4[15 : 0];
  assign _zz_io_i_data_12_6 = _zz_io_i_data_12_4[31 : 16];
  assign addTreeInst_1_io_i_data_12 = (isIntMode ? _zz_io_i_data_12_9 : alignerFP_P_1_12_io_o_mtsa);
  assign _zz_io_i_data_13_4 = mulAB_13_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_13_5 = _zz_io_i_data_13_4[15 : 0];
  assign _zz_io_i_data_13_6 = _zz_io_i_data_13_4[31 : 16];
  assign addTreeInst_1_io_i_data_13 = (isIntMode ? _zz_io_i_data_13_9 : alignerFP_P_1_13_io_o_mtsa);
  assign _zz_io_i_data_14_4 = mulAB_14_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_14_5 = _zz_io_i_data_14_4[15 : 0];
  assign _zz_io_i_data_14_6 = _zz_io_i_data_14_4[31 : 16];
  assign addTreeInst_1_io_i_data_14 = (isIntMode ? _zz_io_i_data_14_9 : alignerFP_P_1_14_io_o_mtsa);
  assign _zz_io_i_data_15_4 = mulAB_15_io_P_mtsa[63 : 32];
  assign _zz_io_i_data_15_5 = _zz_io_i_data_15_4[15 : 0];
  assign _zz_io_i_data_15_6 = _zz_io_i_data_15_4[31 : 16];
  assign addTreeInst_1_io_i_data_15 = (isIntMode ? _zz_io_i_data_15_9 : alignerFP_P_1_15_io_o_mtsa);
  assign addTreeInst_1_io_i_data_16 = (isIntMode ? 56'h0 : alignerFP_C_1_io_o_mtsa);
  assign roundInst_0_io_i_sel = (CDpackMode != PackOp_FP32);
  assign roundInst_1_io_i_sel = (CDpackMode != PackOp_FP32);
  assign intAdder_0_io_i_Q = addTreeInst_0_io_o_data[21 : 0];
  assign intAdder_1_io_i_Q = addTreeInst_0_io_o_data[49 : 28];
  assign intAdder_2_io_i_Q = addTreeInst_1_io_o_data[21 : 0];
  assign intAdder_3_io_i_Q = addTreeInst_1_io_o_data[49 : 28];
  assign vecD_0 = (isIntMode ? intAdder_0_io_o_D : packer_0_io_pack);
  assign vecD_1 = (isIntMode ? intAdder_1_io_o_D : packer_1_io_pack);
  assign vecD_2 = (isIntMode ? intAdder_2_io_o_D : 32'h0);
  assign vecD_3 = (isIntMode ? intAdder_3_io_o_D : 32'h0);
  assign io_vecD = {vecD_3,{vecD_2,{vecD_1,vecD_0}}};
  assign io_nan_f = {packer_1_io_isNaN,packer_0_io_isNaN};
  assign io_inf_f = {packer_1_io_isInf,packer_0_io_isInf};
  assign io_ovf_i = {{{intAdder_3_io_ovf,intAdder_2_io_ovf},intAdder_1_io_ovf},intAdder_0_io_ovf};
  always @(posedge clk) begin
    arithMode <= io_op;
    case(arithMode)
      ArithOp_FP32 : begin
        ABpackMode <= PackOp_FP32;
        CDpackMode <= PackOp_FP32;
      end
      ArithOp_FP16 : begin
        ABpackMode <= PackOp_FP16;
        CDpackMode <= PackOp_FP16;
      end
      ArithOp_FP16_MIX : begin
        ABpackMode <= PackOp_FP16;
        CDpackMode <= PackOp_FP32;
      end
      default : begin
        ABpackMode <= PackOp_INTx;
        CDpackMode <= PackOp_INTx;
      end
    endcase
    io_P_sign_delay_1 <= expAB_0_0_io_P_sign;
    io_P_sign_delay_2 <= io_P_sign_delay_1;
    io_P_sign_delay_3 <= io_P_sign_delay_2;
    io_P_sign_delay_1_1 <= expAB_1_0_io_P_sign;
    io_P_sign_delay_2_1 <= io_P_sign_delay_1_1;
    io_P_sign_delay_3_1 <= io_P_sign_delay_2_1;
    io_P_sign_delay_1_2 <= expAB_0_1_io_P_sign;
    io_P_sign_delay_2_2 <= io_P_sign_delay_1_2;
    io_P_sign_delay_3_2 <= io_P_sign_delay_2_2;
    io_P_sign_delay_1_3 <= expAB_1_1_io_P_sign;
    io_P_sign_delay_2_3 <= io_P_sign_delay_1_3;
    io_P_sign_delay_3_3 <= io_P_sign_delay_2_3;
    io_P_sign_delay_1_4 <= expAB_0_2_io_P_sign;
    io_P_sign_delay_2_4 <= io_P_sign_delay_1_4;
    io_P_sign_delay_3_4 <= io_P_sign_delay_2_4;
    io_P_sign_delay_1_5 <= expAB_1_2_io_P_sign;
    io_P_sign_delay_2_5 <= io_P_sign_delay_1_5;
    io_P_sign_delay_3_5 <= io_P_sign_delay_2_5;
    io_P_sign_delay_1_6 <= expAB_0_3_io_P_sign;
    io_P_sign_delay_2_6 <= io_P_sign_delay_1_6;
    io_P_sign_delay_3_6 <= io_P_sign_delay_2_6;
    io_P_sign_delay_1_7 <= expAB_1_3_io_P_sign;
    io_P_sign_delay_2_7 <= io_P_sign_delay_1_7;
    io_P_sign_delay_3_7 <= io_P_sign_delay_2_7;
    io_P_sign_delay_1_8 <= expAB_0_4_io_P_sign;
    io_P_sign_delay_2_8 <= io_P_sign_delay_1_8;
    io_P_sign_delay_3_8 <= io_P_sign_delay_2_8;
    io_P_sign_delay_1_9 <= expAB_1_4_io_P_sign;
    io_P_sign_delay_2_9 <= io_P_sign_delay_1_9;
    io_P_sign_delay_3_9 <= io_P_sign_delay_2_9;
    io_P_sign_delay_1_10 <= expAB_0_5_io_P_sign;
    io_P_sign_delay_2_10 <= io_P_sign_delay_1_10;
    io_P_sign_delay_3_10 <= io_P_sign_delay_2_10;
    io_P_sign_delay_1_11 <= expAB_1_5_io_P_sign;
    io_P_sign_delay_2_11 <= io_P_sign_delay_1_11;
    io_P_sign_delay_3_11 <= io_P_sign_delay_2_11;
    io_P_sign_delay_1_12 <= expAB_0_6_io_P_sign;
    io_P_sign_delay_2_12 <= io_P_sign_delay_1_12;
    io_P_sign_delay_3_12 <= io_P_sign_delay_2_12;
    io_P_sign_delay_1_13 <= expAB_1_6_io_P_sign;
    io_P_sign_delay_2_13 <= io_P_sign_delay_1_13;
    io_P_sign_delay_3_13 <= io_P_sign_delay_2_13;
    io_P_sign_delay_1_14 <= expAB_0_7_io_P_sign;
    io_P_sign_delay_2_14 <= io_P_sign_delay_1_14;
    io_P_sign_delay_3_14 <= io_P_sign_delay_2_14;
    io_P_sign_delay_1_15 <= expAB_1_7_io_P_sign;
    io_P_sign_delay_2_15 <= io_P_sign_delay_1_15;
    io_P_sign_delay_3_15 <= io_P_sign_delay_2_15;
    io_P_sign_delay_1_16 <= expAB_0_8_io_P_sign;
    io_P_sign_delay_2_16 <= io_P_sign_delay_1_16;
    io_P_sign_delay_3_16 <= io_P_sign_delay_2_16;
    io_P_sign_delay_1_17 <= expAB_1_8_io_P_sign;
    io_P_sign_delay_2_17 <= io_P_sign_delay_1_17;
    io_P_sign_delay_3_17 <= io_P_sign_delay_2_17;
    io_P_sign_delay_1_18 <= expAB_0_9_io_P_sign;
    io_P_sign_delay_2_18 <= io_P_sign_delay_1_18;
    io_P_sign_delay_3_18 <= io_P_sign_delay_2_18;
    io_P_sign_delay_1_19 <= expAB_1_9_io_P_sign;
    io_P_sign_delay_2_19 <= io_P_sign_delay_1_19;
    io_P_sign_delay_3_19 <= io_P_sign_delay_2_19;
    io_P_sign_delay_1_20 <= expAB_0_10_io_P_sign;
    io_P_sign_delay_2_20 <= io_P_sign_delay_1_20;
    io_P_sign_delay_3_20 <= io_P_sign_delay_2_20;
    io_P_sign_delay_1_21 <= expAB_1_10_io_P_sign;
    io_P_sign_delay_2_21 <= io_P_sign_delay_1_21;
    io_P_sign_delay_3_21 <= io_P_sign_delay_2_21;
    io_P_sign_delay_1_22 <= expAB_0_11_io_P_sign;
    io_P_sign_delay_2_22 <= io_P_sign_delay_1_22;
    io_P_sign_delay_3_22 <= io_P_sign_delay_2_22;
    io_P_sign_delay_1_23 <= expAB_1_11_io_P_sign;
    io_P_sign_delay_2_23 <= io_P_sign_delay_1_23;
    io_P_sign_delay_3_23 <= io_P_sign_delay_2_23;
    io_P_sign_delay_1_24 <= expAB_0_12_io_P_sign;
    io_P_sign_delay_2_24 <= io_P_sign_delay_1_24;
    io_P_sign_delay_3_24 <= io_P_sign_delay_2_24;
    io_P_sign_delay_1_25 <= expAB_1_12_io_P_sign;
    io_P_sign_delay_2_25 <= io_P_sign_delay_1_25;
    io_P_sign_delay_3_25 <= io_P_sign_delay_2_25;
    io_P_sign_delay_1_26 <= expAB_0_13_io_P_sign;
    io_P_sign_delay_2_26 <= io_P_sign_delay_1_26;
    io_P_sign_delay_3_26 <= io_P_sign_delay_2_26;
    io_P_sign_delay_1_27 <= expAB_1_13_io_P_sign;
    io_P_sign_delay_2_27 <= io_P_sign_delay_1_27;
    io_P_sign_delay_3_27 <= io_P_sign_delay_2_27;
    io_P_sign_delay_1_28 <= expAB_0_14_io_P_sign;
    io_P_sign_delay_2_28 <= io_P_sign_delay_1_28;
    io_P_sign_delay_3_28 <= io_P_sign_delay_2_28;
    io_P_sign_delay_1_29 <= expAB_1_14_io_P_sign;
    io_P_sign_delay_2_29 <= io_P_sign_delay_1_29;
    io_P_sign_delay_3_29 <= io_P_sign_delay_2_29;
    io_P_sign_delay_1_30 <= expAB_0_15_io_P_sign;
    io_P_sign_delay_2_30 <= io_P_sign_delay_1_30;
    io_P_sign_delay_3_30 <= io_P_sign_delay_2_30;
    io_P_sign_delay_1_31 <= expAB_1_15_io_P_sign;
    io_P_sign_delay_2_31 <= io_P_sign_delay_1_31;
    io_P_sign_delay_3_31 <= io_P_sign_delay_2_31;
    io_c_mtsa_0_delay_1 <= pathCInst_io_c_mtsa_0;
    io_c_mtsa_0_delay_2 <= io_c_mtsa_0_delay_1;
    io_c_mtsa_0_delay_3 <= io_c_mtsa_0_delay_2;
    io_c_sign_0_delay_1 <= pathCInst_io_c_sign_0;
    io_c_sign_0_delay_2 <= io_c_sign_0_delay_1;
    io_c_sign_0_delay_3 <= io_c_sign_0_delay_2;
    io_c_mtsa_1_delay_1 <= pathCInst_io_c_mtsa_1;
    io_c_mtsa_1_delay_2 <= io_c_mtsa_1_delay_1;
    io_c_mtsa_1_delay_3 <= io_c_mtsa_1_delay_2;
    io_c_sign_1_delay_1 <= pathCInst_io_c_sign_1;
    io_c_sign_1_delay_2 <= io_c_sign_1_delay_1;
    io_c_sign_1_delay_3 <= io_c_sign_1_delay_2;
    _zz_io_i_data_0_3 <= {{{6'h0,{6{_zz_io_i_data_0_2[15]}}},_zz_io_i_data_0_2},{{6'h0,{6{_zz_io_i_data_0_1[15]}}},_zz_io_i_data_0_1}};
    _zz_io_i_data_1_3 <= {{{6'h0,{6{_zz_io_i_data_1_2[15]}}},_zz_io_i_data_1_2},{{6'h0,{6{_zz_io_i_data_1_1[15]}}},_zz_io_i_data_1_1}};
    _zz_io_i_data_2_3 <= {{{6'h0,{6{_zz_io_i_data_2_2[15]}}},_zz_io_i_data_2_2},{{6'h0,{6{_zz_io_i_data_2_1[15]}}},_zz_io_i_data_2_1}};
    _zz_io_i_data_3_3 <= {{{6'h0,{6{_zz_io_i_data_3_2[15]}}},_zz_io_i_data_3_2},{{6'h0,{6{_zz_io_i_data_3_1[15]}}},_zz_io_i_data_3_1}};
    _zz_io_i_data_4_3 <= {{{6'h0,{6{_zz_io_i_data_4_2[15]}}},_zz_io_i_data_4_2},{{6'h0,{6{_zz_io_i_data_4_1[15]}}},_zz_io_i_data_4_1}};
    _zz_io_i_data_5_3 <= {{{6'h0,{6{_zz_io_i_data_5_2[15]}}},_zz_io_i_data_5_2},{{6'h0,{6{_zz_io_i_data_5_1[15]}}},_zz_io_i_data_5_1}};
    _zz_io_i_data_6_3 <= {{{6'h0,{6{_zz_io_i_data_6_2[15]}}},_zz_io_i_data_6_2},{{6'h0,{6{_zz_io_i_data_6_1[15]}}},_zz_io_i_data_6_1}};
    _zz_io_i_data_7_3 <= {{{6'h0,{6{_zz_io_i_data_7_2[15]}}},_zz_io_i_data_7_2},{{6'h0,{6{_zz_io_i_data_7_1[15]}}},_zz_io_i_data_7_1}};
    _zz_io_i_data_8_3 <= {{{6'h0,{6{_zz_io_i_data_8_2[15]}}},_zz_io_i_data_8_2},{{6'h0,{6{_zz_io_i_data_8_1[15]}}},_zz_io_i_data_8_1}};
    _zz_io_i_data_9_3 <= {{{6'h0,{6{_zz_io_i_data_9_2[15]}}},_zz_io_i_data_9_2},{{6'h0,{6{_zz_io_i_data_9_1[15]}}},_zz_io_i_data_9_1}};
    _zz_io_i_data_10_3 <= {{{6'h0,{6{_zz_io_i_data_10_2[15]}}},_zz_io_i_data_10_2},{{6'h0,{6{_zz_io_i_data_10_1[15]}}},_zz_io_i_data_10_1}};
    _zz_io_i_data_11_3 <= {{{6'h0,{6{_zz_io_i_data_11_2[15]}}},_zz_io_i_data_11_2},{{6'h0,{6{_zz_io_i_data_11_1[15]}}},_zz_io_i_data_11_1}};
    _zz_io_i_data_12_3 <= {{{6'h0,{6{_zz_io_i_data_12_2[15]}}},_zz_io_i_data_12_2},{{6'h0,{6{_zz_io_i_data_12_1[15]}}},_zz_io_i_data_12_1}};
    _zz_io_i_data_13_3 <= {{{6'h0,{6{_zz_io_i_data_13_2[15]}}},_zz_io_i_data_13_2},{{6'h0,{6{_zz_io_i_data_13_1[15]}}},_zz_io_i_data_13_1}};
    _zz_io_i_data_14_3 <= {{{6'h0,{6{_zz_io_i_data_14_2[15]}}},_zz_io_i_data_14_2},{{6'h0,{6{_zz_io_i_data_14_1[15]}}},_zz_io_i_data_14_1}};
    _zz_io_i_data_15_3 <= {{{6'h0,{6{_zz_io_i_data_15_2[15]}}},_zz_io_i_data_15_2},{{6'h0,{6{_zz_io_i_data_15_1[15]}}},_zz_io_i_data_15_1}};
    _zz_io_i_data_0_7 <= {{{6'h0,{6{_zz_io_i_data_0_6[15]}}},_zz_io_i_data_0_6},{{6'h0,{6{_zz_io_i_data_0_5[15]}}},_zz_io_i_data_0_5}};
    _zz_io_i_data_1_7 <= {{{6'h0,{6{_zz_io_i_data_1_6[15]}}},_zz_io_i_data_1_6},{{6'h0,{6{_zz_io_i_data_1_5[15]}}},_zz_io_i_data_1_5}};
    _zz_io_i_data_2_7 <= {{{6'h0,{6{_zz_io_i_data_2_6[15]}}},_zz_io_i_data_2_6},{{6'h0,{6{_zz_io_i_data_2_5[15]}}},_zz_io_i_data_2_5}};
    _zz_io_i_data_3_7 <= {{{6'h0,{6{_zz_io_i_data_3_6[15]}}},_zz_io_i_data_3_6},{{6'h0,{6{_zz_io_i_data_3_5[15]}}},_zz_io_i_data_3_5}};
    _zz_io_i_data_4_7 <= {{{6'h0,{6{_zz_io_i_data_4_6[15]}}},_zz_io_i_data_4_6},{{6'h0,{6{_zz_io_i_data_4_5[15]}}},_zz_io_i_data_4_5}};
    _zz_io_i_data_5_7 <= {{{6'h0,{6{_zz_io_i_data_5_6[15]}}},_zz_io_i_data_5_6},{{6'h0,{6{_zz_io_i_data_5_5[15]}}},_zz_io_i_data_5_5}};
    _zz_io_i_data_6_7 <= {{{6'h0,{6{_zz_io_i_data_6_6[15]}}},_zz_io_i_data_6_6},{{6'h0,{6{_zz_io_i_data_6_5[15]}}},_zz_io_i_data_6_5}};
    _zz_io_i_data_7_7 <= {{{6'h0,{6{_zz_io_i_data_7_6[15]}}},_zz_io_i_data_7_6},{{6'h0,{6{_zz_io_i_data_7_5[15]}}},_zz_io_i_data_7_5}};
    _zz_io_i_data_8_7 <= {{{6'h0,{6{_zz_io_i_data_8_6[15]}}},_zz_io_i_data_8_6},{{6'h0,{6{_zz_io_i_data_8_5[15]}}},_zz_io_i_data_8_5}};
    _zz_io_i_data_9_7 <= {{{6'h0,{6{_zz_io_i_data_9_6[15]}}},_zz_io_i_data_9_6},{{6'h0,{6{_zz_io_i_data_9_5[15]}}},_zz_io_i_data_9_5}};
    _zz_io_i_data_10_7 <= {{{6'h0,{6{_zz_io_i_data_10_6[15]}}},_zz_io_i_data_10_6},{{6'h0,{6{_zz_io_i_data_10_5[15]}}},_zz_io_i_data_10_5}};
    _zz_io_i_data_11_7 <= {{{6'h0,{6{_zz_io_i_data_11_6[15]}}},_zz_io_i_data_11_6},{{6'h0,{6{_zz_io_i_data_11_5[15]}}},_zz_io_i_data_11_5}};
    _zz_io_i_data_12_7 <= {{{6'h0,{6{_zz_io_i_data_12_6[15]}}},_zz_io_i_data_12_6},{{6'h0,{6{_zz_io_i_data_12_5[15]}}},_zz_io_i_data_12_5}};
    _zz_io_i_data_13_7 <= {{{6'h0,{6{_zz_io_i_data_13_6[15]}}},_zz_io_i_data_13_6},{{6'h0,{6{_zz_io_i_data_13_5[15]}}},_zz_io_i_data_13_5}};
    _zz_io_i_data_14_7 <= {{{6'h0,{6{_zz_io_i_data_14_6[15]}}},_zz_io_i_data_14_6},{{6'h0,{6{_zz_io_i_data_14_5[15]}}},_zz_io_i_data_14_5}};
    _zz_io_i_data_15_7 <= {{{6'h0,{6{_zz_io_i_data_15_6[15]}}},_zz_io_i_data_15_6},{{6'h0,{6{_zz_io_i_data_15_5[15]}}},_zz_io_i_data_15_5}};
    io_Q_expn_delay_1 <= nrshP_0_io_Q_expn;
    io_Q_expn_delay_2 <= io_Q_expn_delay_1;
    io_Q_expn_delay_3 <= io_Q_expn_delay_2;
    io_Q_expn_delay_4 <= io_Q_expn_delay_3;
    io_Q_expn_delay_5 <= io_Q_expn_delay_4;
    io_Q_sign_delay_1 <= nrshP_0_io_Q_sign;
    io_Q_sign_delay_2 <= io_Q_sign_delay_1;
    io_Q_sign_delay_3 <= io_Q_sign_delay_2;
    io_Q_sign_delay_4 <= io_Q_sign_delay_3;
    io_Q_sign_delay_5 <= io_Q_sign_delay_4;
    io_Q_flag_delay_1 <= nrshP_0_io_Q_flag;
    io_Q_flag_delay_2 <= io_Q_flag_delay_1;
    io_Q_flag_delay_3 <= io_Q_flag_delay_2;
    io_Q_flag_delay_4 <= io_Q_flag_delay_3;
    io_Q_flag_delay_5 <= io_Q_flag_delay_4;
    io_Q_expn_delay_1_1 <= nrshP_1_io_Q_expn;
    io_Q_expn_delay_2_1 <= io_Q_expn_delay_1_1;
    io_Q_expn_delay_3_1 <= io_Q_expn_delay_2_1;
    io_Q_expn_delay_4_1 <= io_Q_expn_delay_3_1;
    io_Q_expn_delay_5_1 <= io_Q_expn_delay_4_1;
    io_Q_sign_delay_1_1 <= nrshP_1_io_Q_sign;
    io_Q_sign_delay_2_1 <= io_Q_sign_delay_1_1;
    io_Q_sign_delay_3_1 <= io_Q_sign_delay_2_1;
    io_Q_sign_delay_4_1 <= io_Q_sign_delay_3_1;
    io_Q_sign_delay_5_1 <= io_Q_sign_delay_4_1;
    io_Q_flag_delay_1_1 <= nrshP_1_io_Q_flag;
    io_Q_flag_delay_2_1 <= io_Q_flag_delay_1_1;
    io_Q_flag_delay_3_1 <= io_Q_flag_delay_2_1;
    io_Q_flag_delay_4_1 <= io_Q_flag_delay_3_1;
    io_Q_flag_delay_5_1 <= io_Q_flag_delay_4_1;
    _zz_io_i_C <= vecC_0;
    _zz_io_i_C_1 <= _zz_io_i_C;
    _zz_io_i_C_2 <= _zz_io_i_C_1;
    _zz_io_i_C_3 <= _zz_io_i_C_2;
    _zz_io_i_C_4 <= _zz_io_i_C_3;
    _zz_io_i_C_5 <= _zz_io_i_C_4;
    _zz_io_i_C_6 <= _zz_io_i_C_5;
    _zz_io_i_C_7 <= _zz_io_i_C_6;
    _zz_io_i_C_8 <= _zz_io_i_C_7;
    _zz_io_i_C_9 <= vecC_1;
    _zz_io_i_C_10 <= _zz_io_i_C_9;
    _zz_io_i_C_11 <= _zz_io_i_C_10;
    _zz_io_i_C_12 <= _zz_io_i_C_11;
    _zz_io_i_C_13 <= _zz_io_i_C_12;
    _zz_io_i_C_14 <= _zz_io_i_C_13;
    _zz_io_i_C_15 <= _zz_io_i_C_14;
    _zz_io_i_C_16 <= _zz_io_i_C_15;
    _zz_io_i_C_17 <= _zz_io_i_C_16;
    _zz_io_i_C_18 <= vecC_2;
    _zz_io_i_C_19 <= _zz_io_i_C_18;
    _zz_io_i_C_20 <= _zz_io_i_C_19;
    _zz_io_i_C_21 <= _zz_io_i_C_20;
    _zz_io_i_C_22 <= _zz_io_i_C_21;
    _zz_io_i_C_23 <= _zz_io_i_C_22;
    _zz_io_i_C_24 <= _zz_io_i_C_23;
    _zz_io_i_C_25 <= _zz_io_i_C_24;
    _zz_io_i_C_26 <= _zz_io_i_C_25;
    _zz_io_i_C_27 <= vecC_3;
    _zz_io_i_C_28 <= _zz_io_i_C_27;
    _zz_io_i_C_29 <= _zz_io_i_C_28;
    _zz_io_i_C_30 <= _zz_io_i_C_29;
    _zz_io_i_C_31 <= _zz_io_i_C_30;
    _zz_io_i_C_32 <= _zz_io_i_C_31;
    _zz_io_i_C_33 <= _zz_io_i_C_32;
    _zz_io_i_C_34 <= _zz_io_i_C_33;
    _zz_io_i_C_35 <= _zz_io_i_C_34;
  end


endmodule

//intAdderChecker_3 replaced by intAdderChecker

//intAdderChecker_2 replaced by intAdderChecker

//intAdderChecker_1 replaced by intAdderChecker

module intAdderChecker (
  input  wire [31:0]   io_i_C,
  input  wire [21:0]   io_i_Q,
  output wire [31:0]   io_o_D,
  output wire          io_ovf,
  input  wire          clk,
  input  wire          resetn
);

  wire       [32:0]   _zz_sum;
  wire       [32:0]   _zz_sum_1;
  wire       [22:0]   _zz_sum_2;
  wire       [32:0]   sum;
  wire                ovf;
  reg        [31:0]   _zz_io_o_D;
  reg                 ovf_regNext;

  assign _zz_sum = {io_i_C[31],io_i_C};
  assign _zz_sum_2 = {io_i_Q[21],io_i_Q};
  assign _zz_sum_1 = {{10{_zz_sum_2[22]}}, _zz_sum_2};
  assign sum = ($signed(_zz_sum) + $signed(_zz_sum_1));
  assign ovf = (sum[32] != sum[31]);
  assign io_o_D = _zz_io_o_D;
  assign io_ovf = ovf_regNext;
  always @(posedge clk) begin
    _zz_io_o_D <= sum[31 : 0];
    ovf_regNext <= ovf;
  end


endmodule

//adderTree_7 replaced by adderTree

//FPalignUnit_39 replaced by FPalignUnit

//adderTree_6 replaced by adderTree

//FPalignUnit_38 replaced by FPalignUnit

//adderTree_5 replaced by adderTree

//FPalignUnit_37 replaced by FPalignUnit

//adderTree_4 replaced by adderTree

//FPalignUnit_36 replaced by FPalignUnit

//adderTree_3 replaced by adderTree

//FPalignUnit_35 replaced by FPalignUnit

//adderTree_2 replaced by adderTree

//FPalignUnit_34 replaced by FPalignUnit

//packUnit_1 replaced by packUnit

module packUnit (
  input  wire [1:0]    io_op,
  input  wire [23:0]   io_mtsa,
  input  wire [9:0]    io_expn,
  input  wire          io_sign,
  input  wire [1:0]    io_flag,
  output wire [31:0]   io_pack,
  output wire          io_isNaN,
  output wire          io_isInf,
  input  wire          clk,
  input  wire          resetn
);
  localparam PackOp_INTx = 2'd0;
  localparam PackOp_FP32 = 2'd1;
  localparam PackOp_FP16 = 2'd2;
  localparam FpFlag_ZERO = 2'd0;
  localparam FpFlag_NORM = 2'd1;
  localparam FpFlag_INF = 2'd2;
  localparam FpFlag_NAN = 2'd3;

  wire       [7:0]    _zz_fp32_y_expn;
  wire       [4:0]    _zz_fp16_y_expn;
  wire                fp32_isNaN;
  wire                fp32_isInf;
  wire                fp32_isZero;
  reg        [22:0]   fp32_y_frac;
  reg        [7:0]    fp32_y_expn;
  wire                when_packUnit_l123;
  wire       [31:0]   fp32_y_pack;
  wire       [10:0]   _zz_fp16_isZero;
  wire                fp16_isNaN;
  wire                fp16_isInf;
  wire                fp16_isZero;
  reg        [9:0]    fp16_y_frac;
  reg        [4:0]    fp16_y_expn;
  wire                when_packUnit_l123_1;
  wire       [15:0]   fp16_y_pack;
  reg        [31:0]   yPack;
  reg                 isNaN;
  reg                 isInf;
  reg        [31:0]   yPack_regNext;
  reg                 isNaN_regNext;
  reg                 isInf_regNext;
  `ifndef SYNTHESIS
  reg [31:0] io_op_string;
  reg [31:0] io_flag_string;
  `endif


  assign _zz_fp32_y_expn = io_expn[7 : 0];
  assign _zz_fp16_y_expn = io_expn[4 : 0];
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      PackOp_INTx : io_op_string = "INTx";
      PackOp_FP32 : io_op_string = "FP32";
      PackOp_FP16 : io_op_string = "FP16";
      default : io_op_string = "????";
    endcase
  end
  always @(*) begin
    case(io_flag)
      FpFlag_ZERO : io_flag_string = "ZERO";
      FpFlag_NORM : io_flag_string = "NORM";
      FpFlag_INF : io_flag_string = "INF ";
      FpFlag_NAN : io_flag_string = "NAN ";
      default : io_flag_string = "????";
    endcase
  end
  `endif

  assign fp32_isNaN = (io_flag == FpFlag_NAN);
  assign fp32_isInf = ((! fp32_isNaN) && ((io_flag == FpFlag_INF) || ($signed(10'h0ff) <= $signed(io_expn))));
  assign fp32_isZero = (io_mtsa == 24'h0);
  always @(*) begin
    if(fp32_isNaN) begin
      fp32_y_frac = 23'h7fffff;
    end else begin
      if(fp32_isInf) begin
        fp32_y_frac = 23'h0;
      end else begin
        if(fp32_isZero) begin
          fp32_y_frac = 23'h0;
        end else begin
          if(when_packUnit_l123) begin
            fp32_y_frac = io_mtsa[22 : 0];
          end else begin
            fp32_y_frac = io_mtsa[22 : 0];
          end
        end
      end
    end
  end

  always @(*) begin
    if(fp32_isNaN) begin
      fp32_y_expn = 8'hff;
    end else begin
      if(fp32_isInf) begin
        fp32_y_expn = 8'hff;
      end else begin
        if(fp32_isZero) begin
          fp32_y_expn = 8'h0;
        end else begin
          if(when_packUnit_l123) begin
            fp32_y_expn = 8'h0;
          end else begin
            fp32_y_expn = _zz_fp32_y_expn;
          end
        end
      end
    end
  end

  assign when_packUnit_l123 = (($signed(io_expn) == $signed(10'h001)) && (! io_mtsa[23]));
  assign fp32_y_pack = {{io_sign,fp32_y_expn},fp32_y_frac};
  assign _zz_fp16_isZero = io_mtsa[10 : 0];
  assign fp16_isNaN = (io_flag == FpFlag_NAN);
  assign fp16_isInf = ((! fp16_isNaN) && ((io_flag == FpFlag_INF) || ($signed(10'h01f) <= $signed(io_expn))));
  assign fp16_isZero = (_zz_fp16_isZero == 11'h0);
  always @(*) begin
    if(fp16_isNaN) begin
      fp16_y_frac = 10'h3ff;
    end else begin
      if(fp16_isInf) begin
        fp16_y_frac = 10'h0;
      end else begin
        if(fp16_isZero) begin
          fp16_y_frac = 10'h0;
        end else begin
          if(when_packUnit_l123_1) begin
            fp16_y_frac = _zz_fp16_isZero[9 : 0];
          end else begin
            fp16_y_frac = _zz_fp16_isZero[9 : 0];
          end
        end
      end
    end
  end

  always @(*) begin
    if(fp16_isNaN) begin
      fp16_y_expn = 5'h1f;
    end else begin
      if(fp16_isInf) begin
        fp16_y_expn = 5'h1f;
      end else begin
        if(fp16_isZero) begin
          fp16_y_expn = 5'h0;
        end else begin
          if(when_packUnit_l123_1) begin
            fp16_y_expn = 5'h0;
          end else begin
            fp16_y_expn = _zz_fp16_y_expn;
          end
        end
      end
    end
  end

  assign when_packUnit_l123_1 = (($signed(io_expn) == $signed(10'h001)) && (! _zz_fp16_isZero[10]));
  assign fp16_y_pack = {{io_sign,fp16_y_expn},fp16_y_frac};
  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        yPack = fp32_y_pack;
      end
      PackOp_FP16 : begin
        yPack = {16'h0,fp16_y_pack};
      end
      default : begin
        yPack = 32'h0;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        isNaN = fp32_isNaN;
      end
      PackOp_FP16 : begin
        isNaN = fp16_isNaN;
      end
      default : begin
        isNaN = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        isInf = fp32_isInf;
      end
      PackOp_FP16 : begin
        isInf = fp16_isInf;
      end
      default : begin
        isInf = 1'b0;
      end
    endcase
  end

  assign io_pack = yPack_regNext;
  assign io_isNaN = isNaN_regNext;
  assign io_isInf = isInf_regNext;
  always @(posedge clk) begin
    yPack_regNext <= yPack;
    isNaN_regNext <= isNaN;
    isInf_regNext <= isInf;
  end


endmodule

//normRoundUnit_1 replaced by normRoundUnit

module normRoundUnit (
  input  wire          io_i_sel,
  input  wire [55:0]   io_i_mtsa,
  input  wire [9:0]    io_i_expn,
  input  wire          io_i_sign,
  input  wire [1:0]    io_i_flag,
  output wire [23:0]   io_o_mtsa,
  output wire [9:0]    io_o_expn,
  output wire          io_o_sign,
  output wire [1:0]    io_o_flag,
  input  wire          clk,
  input  wire          resetn
);
  localparam FpFlag_ZERO = 2'd0;
  localparam FpFlag_NORM = 2'd1;
  localparam FpFlag_INF = 2'd2;
  localparam FpFlag_NAN = 2'd3;

  wire       [55:0]   _zz_n1_MTSA;
  wire       [55:0]   _zz_n1_MTSA_1;
  wire       [55:0]   _zz_n1_MTSA_2;
  wire       [0:0]    _zz_n1_MTSA_3;
  wire       [9:0]    _zz_n2_expn_1;
  wire       [9:0]    _zz_n2_expn_1_1;
  wire       [9:0]    _zz_n2_expn_1_2;
  wire       [7:0]    _zz_n2_expn_1_3;
  wire       [9:0]    _zz_n3_rsh;
  wire       [9:0]    _zz_n3_expn_1;
  wire       [23:0]   _zz_n4_roundUnit_0_o_mtsa;
  wire       [9:0]    _zz_n4_roundUnit_0_o_expn;
  wire       [10:0]   _zz_n4_roundUnit_1_o_mtsa;
  wire       [9:0]    _zz_n4_roundUnit_1_o_expn;
  wire       [23:0]   _zz_n4_MTSA;
  reg        [1:0]    n4_n1_FLAG;
  reg                 n4_n1_SIGN;
  reg                 n3_n1_SEL;
  reg        [1:0]    n3_n1_FLAG;
  reg                 n3_n1_SIGN;
  reg        [1:0]    n2_n1_FLAG;
  reg                 n2_n1_SIGN;
  reg        [1:0]    n5_n1_FLAG;
  reg                 n5_n1_SIGN;
  reg        [9:0]    n5_n4_EXPN;
  reg        [23:0]   n5_n4_MTSA;
  wire       [9:0]    n4_EXPN;
  wire       [23:0]   n4_MTSA;
  reg                 n4_n1_SEL;
  reg        [9:0]    n4_n3_EXPN;
  reg        [55:0]   n4_n3_MTSA;
  wire       [9:0]    n3_EXPN;
  wire       [55:0]   n3_MTSA;
  reg        [55:0]   n3_n2_MTSA;
  reg        [9:0]    n3_n2_EXPN;
  wire       [9:0]    n2_EXPN;
  wire       [55:0]   n2_MTSA;
  reg        [9:0]    n2_n1_EXPN;
  reg                 n2_n1_SEL;
  reg        [55:0]   n2_n1_MTSA;
  wire                n1_SEL;
  wire       [1:0]    n1_FLAG;
  wire                n1_SIGN;
  wire       [9:0]    n1_EXPN;
  wire       [55:0]   n1_MTSA;
  reg                 n1_sign_1;
  reg        [1:0]    n1_flag_1;
  wire                when_normRoundUnit_l31;
  wire                when_normRoundUnit_l36;
  wire       [63:0]   _zz_n2_ldz;
  wire       [31:0]   _zz_n2_ldz_1;
  wire       [15:0]   _zz_n2_ldz_2;
  wire       [7:0]    _zz_n2_ldz_3;
  wire       [3:0]    _zz_n2_ldz_4;
  wire       [1:0]    _zz_n2_ldz_5;
  wire       [0:0]    _zz_n2_ldz_6;
  wire       [0:0]    _zz_n2_ldz_7;
  wire       [1:0]    _zz_n2_ldz_8;
  wire       [1:0]    _zz_n2_ldz_9;
  wire       [0:0]    _zz_n2_ldz_10;
  wire       [0:0]    _zz_n2_ldz_11;
  wire       [1:0]    _zz_n2_ldz_12;
  wire       [2:0]    _zz_n2_ldz_13;
  wire       [3:0]    _zz_n2_ldz_14;
  wire       [1:0]    _zz_n2_ldz_15;
  wire       [0:0]    _zz_n2_ldz_16;
  wire       [0:0]    _zz_n2_ldz_17;
  wire       [1:0]    _zz_n2_ldz_18;
  wire       [1:0]    _zz_n2_ldz_19;
  wire       [0:0]    _zz_n2_ldz_20;
  wire       [0:0]    _zz_n2_ldz_21;
  wire       [1:0]    _zz_n2_ldz_22;
  wire       [2:0]    _zz_n2_ldz_23;
  wire       [3:0]    _zz_n2_ldz_24;
  wire       [7:0]    _zz_n2_ldz_25;
  wire       [3:0]    _zz_n2_ldz_26;
  wire       [1:0]    _zz_n2_ldz_27;
  wire       [0:0]    _zz_n2_ldz_28;
  wire       [0:0]    _zz_n2_ldz_29;
  wire       [1:0]    _zz_n2_ldz_30;
  wire       [1:0]    _zz_n2_ldz_31;
  wire       [0:0]    _zz_n2_ldz_32;
  wire       [0:0]    _zz_n2_ldz_33;
  wire       [1:0]    _zz_n2_ldz_34;
  wire       [2:0]    _zz_n2_ldz_35;
  wire       [3:0]    _zz_n2_ldz_36;
  wire       [1:0]    _zz_n2_ldz_37;
  wire       [0:0]    _zz_n2_ldz_38;
  wire       [0:0]    _zz_n2_ldz_39;
  wire       [1:0]    _zz_n2_ldz_40;
  wire       [1:0]    _zz_n2_ldz_41;
  wire       [0:0]    _zz_n2_ldz_42;
  wire       [0:0]    _zz_n2_ldz_43;
  wire       [1:0]    _zz_n2_ldz_44;
  wire       [2:0]    _zz_n2_ldz_45;
  wire       [3:0]    _zz_n2_ldz_46;
  wire       [4:0]    _zz_n2_ldz_47;
  wire       [15:0]   _zz_n2_ldz_48;
  wire       [7:0]    _zz_n2_ldz_49;
  wire       [3:0]    _zz_n2_ldz_50;
  wire       [1:0]    _zz_n2_ldz_51;
  wire       [0:0]    _zz_n2_ldz_52;
  wire       [0:0]    _zz_n2_ldz_53;
  wire       [1:0]    _zz_n2_ldz_54;
  wire       [1:0]    _zz_n2_ldz_55;
  wire       [0:0]    _zz_n2_ldz_56;
  wire       [0:0]    _zz_n2_ldz_57;
  wire       [1:0]    _zz_n2_ldz_58;
  wire       [2:0]    _zz_n2_ldz_59;
  wire       [3:0]    _zz_n2_ldz_60;
  wire       [1:0]    _zz_n2_ldz_61;
  wire       [0:0]    _zz_n2_ldz_62;
  wire       [0:0]    _zz_n2_ldz_63;
  wire       [1:0]    _zz_n2_ldz_64;
  wire       [1:0]    _zz_n2_ldz_65;
  wire       [0:0]    _zz_n2_ldz_66;
  wire       [0:0]    _zz_n2_ldz_67;
  wire       [1:0]    _zz_n2_ldz_68;
  wire       [2:0]    _zz_n2_ldz_69;
  wire       [3:0]    _zz_n2_ldz_70;
  wire       [7:0]    _zz_n2_ldz_71;
  wire       [3:0]    _zz_n2_ldz_72;
  wire       [1:0]    _zz_n2_ldz_73;
  wire       [0:0]    _zz_n2_ldz_74;
  wire       [0:0]    _zz_n2_ldz_75;
  wire       [1:0]    _zz_n2_ldz_76;
  wire       [1:0]    _zz_n2_ldz_77;
  wire       [0:0]    _zz_n2_ldz_78;
  wire       [0:0]    _zz_n2_ldz_79;
  wire       [1:0]    _zz_n2_ldz_80;
  wire       [2:0]    _zz_n2_ldz_81;
  wire       [3:0]    _zz_n2_ldz_82;
  wire       [1:0]    _zz_n2_ldz_83;
  wire       [0:0]    _zz_n2_ldz_84;
  wire       [0:0]    _zz_n2_ldz_85;
  wire       [1:0]    _zz_n2_ldz_86;
  wire       [1:0]    _zz_n2_ldz_87;
  wire       [0:0]    _zz_n2_ldz_88;
  wire       [0:0]    _zz_n2_ldz_89;
  wire       [1:0]    _zz_n2_ldz_90;
  wire       [2:0]    _zz_n2_ldz_91;
  wire       [3:0]    _zz_n2_ldz_92;
  wire       [4:0]    _zz_n2_ldz_93;
  wire       [5:0]    _zz_n2_ldz_94;
  wire       [31:0]   _zz_n2_ldz_95;
  wire       [15:0]   _zz_n2_ldz_96;
  wire       [7:0]    _zz_n2_ldz_97;
  wire       [3:0]    _zz_n2_ldz_98;
  wire       [1:0]    _zz_n2_ldz_99;
  wire       [0:0]    _zz_n2_ldz_100;
  wire       [0:0]    _zz_n2_ldz_101;
  wire       [1:0]    _zz_n2_ldz_102;
  wire       [1:0]    _zz_n2_ldz_103;
  wire       [0:0]    _zz_n2_ldz_104;
  wire       [0:0]    _zz_n2_ldz_105;
  wire       [1:0]    _zz_n2_ldz_106;
  wire       [2:0]    _zz_n2_ldz_107;
  wire       [3:0]    _zz_n2_ldz_108;
  wire       [1:0]    _zz_n2_ldz_109;
  wire       [0:0]    _zz_n2_ldz_110;
  wire       [0:0]    _zz_n2_ldz_111;
  wire       [1:0]    _zz_n2_ldz_112;
  wire       [1:0]    _zz_n2_ldz_113;
  wire       [0:0]    _zz_n2_ldz_114;
  wire       [0:0]    _zz_n2_ldz_115;
  wire       [1:0]    _zz_n2_ldz_116;
  wire       [2:0]    _zz_n2_ldz_117;
  wire       [3:0]    _zz_n2_ldz_118;
  wire       [7:0]    _zz_n2_ldz_119;
  wire       [3:0]    _zz_n2_ldz_120;
  wire       [1:0]    _zz_n2_ldz_121;
  wire       [0:0]    _zz_n2_ldz_122;
  wire       [0:0]    _zz_n2_ldz_123;
  wire       [1:0]    _zz_n2_ldz_124;
  wire       [1:0]    _zz_n2_ldz_125;
  wire       [0:0]    _zz_n2_ldz_126;
  wire       [0:0]    _zz_n2_ldz_127;
  wire       [1:0]    _zz_n2_ldz_128;
  wire       [2:0]    _zz_n2_ldz_129;
  wire       [3:0]    _zz_n2_ldz_130;
  wire       [1:0]    _zz_n2_ldz_131;
  wire       [0:0]    _zz_n2_ldz_132;
  wire       [0:0]    _zz_n2_ldz_133;
  wire       [1:0]    _zz_n2_ldz_134;
  wire       [1:0]    _zz_n2_ldz_135;
  wire       [0:0]    _zz_n2_ldz_136;
  wire       [0:0]    _zz_n2_ldz_137;
  wire       [1:0]    _zz_n2_ldz_138;
  wire       [2:0]    _zz_n2_ldz_139;
  wire       [3:0]    _zz_n2_ldz_140;
  wire       [4:0]    _zz_n2_ldz_141;
  wire       [15:0]   _zz_n2_ldz_142;
  wire       [7:0]    _zz_n2_ldz_143;
  wire       [3:0]    _zz_n2_ldz_144;
  wire       [1:0]    _zz_n2_ldz_145;
  wire       [0:0]    _zz_n2_ldz_146;
  wire       [0:0]    _zz_n2_ldz_147;
  wire       [1:0]    _zz_n2_ldz_148;
  wire       [1:0]    _zz_n2_ldz_149;
  wire       [0:0]    _zz_n2_ldz_150;
  wire       [0:0]    _zz_n2_ldz_151;
  wire       [1:0]    _zz_n2_ldz_152;
  wire       [2:0]    _zz_n2_ldz_153;
  wire       [3:0]    _zz_n2_ldz_154;
  wire       [1:0]    _zz_n2_ldz_155;
  wire       [0:0]    _zz_n2_ldz_156;
  wire       [0:0]    _zz_n2_ldz_157;
  wire       [1:0]    _zz_n2_ldz_158;
  wire       [1:0]    _zz_n2_ldz_159;
  wire       [0:0]    _zz_n2_ldz_160;
  wire       [0:0]    _zz_n2_ldz_161;
  wire       [1:0]    _zz_n2_ldz_162;
  wire       [2:0]    _zz_n2_ldz_163;
  wire       [3:0]    _zz_n2_ldz_164;
  wire       [7:0]    _zz_n2_ldz_165;
  wire       [3:0]    _zz_n2_ldz_166;
  wire       [1:0]    _zz_n2_ldz_167;
  wire       [0:0]    _zz_n2_ldz_168;
  wire       [0:0]    _zz_n2_ldz_169;
  wire       [1:0]    _zz_n2_ldz_170;
  wire       [1:0]    _zz_n2_ldz_171;
  wire       [0:0]    _zz_n2_ldz_172;
  wire       [0:0]    _zz_n2_ldz_173;
  wire       [1:0]    _zz_n2_ldz_174;
  wire       [2:0]    _zz_n2_ldz_175;
  wire       [3:0]    _zz_n2_ldz_176;
  wire       [1:0]    _zz_n2_ldz_177;
  wire       [0:0]    _zz_n2_ldz_178;
  wire       [0:0]    _zz_n2_ldz_179;
  wire       [1:0]    _zz_n2_ldz_180;
  wire       [1:0]    _zz_n2_ldz_181;
  wire       [0:0]    _zz_n2_ldz_182;
  wire       [0:0]    _zz_n2_ldz_183;
  wire       [1:0]    _zz_n2_ldz_184;
  wire       [2:0]    _zz_n2_ldz_185;
  wire       [3:0]    _zz_n2_ldz_186;
  wire       [4:0]    _zz_n2_ldz_187;
  wire       [5:0]    _zz_n2_ldz_188;
  wire       [6:0]    n2_ldz;
  wire       [3:0]    n2_adj;
  wire       [9:0]    n2_expn_1;
  wire       [55:0]   n2_mtsa_1;
  wire       [9:0]    n3_rsh;
  wire       [9:0]    n3_expn_1;
  wire       [55:0]   n3_mtsa_1;
  wire       [23:0]   n4_roundUnit_0_mtsa_clip;
  wire                n4_roundUnit_0_round_bit;
  wire       [30:0]   n4_roundUnit_0_stick_bit;
  wire                n4_roundUnit_0_cond;
  reg        [23:0]   n4_roundUnit_0_o_mtsa;
  reg        [9:0]    n4_roundUnit_0_o_expn;
  wire       [10:0]   n4_roundUnit_1_mtsa_clip;
  wire                n4_roundUnit_1_round_bit;
  wire       [43:0]   n4_roundUnit_1_stick_bit;
  wire                n4_roundUnit_1_cond;
  reg        [10:0]   n4_roundUnit_1_o_mtsa;
  reg        [9:0]    n4_roundUnit_1_o_expn;
  `ifndef SYNTHESIS
  reg [31:0] n4_n1_FLAG_string;
  reg [31:0] n3_n1_FLAG_string;
  reg [31:0] n2_n1_FLAG_string;
  reg [31:0] n5_n1_FLAG_string;
  reg [31:0] n1_FLAG_string;
  reg [31:0] io_i_flag_string;
  reg [31:0] io_o_flag_string;
  reg [31:0] n1_flag_1_string;
  `endif


  assign _zz_n1_MTSA = (io_i_mtsa[55] ? _zz_n1_MTSA_1 : io_i_mtsa);
  assign _zz_n1_MTSA_1 = (~ io_i_mtsa);
  assign _zz_n1_MTSA_3 = io_i_mtsa[55];
  assign _zz_n1_MTSA_2 = {55'd0, _zz_n1_MTSA_3};
  assign _zz_n2_expn_1 = ($signed(n2_n1_EXPN) + $signed(_zz_n2_expn_1_1));
  assign _zz_n2_expn_1_1 = {{6{n2_adj[3]}}, n2_adj};
  assign _zz_n2_expn_1_3 = {1'b0,n2_ldz};
  assign _zz_n2_expn_1_2 = {{2{_zz_n2_expn_1_3[7]}}, _zz_n2_expn_1_3};
  assign _zz_n3_rsh = ($signed(10'h001) - $signed(n3_n2_EXPN));
  assign _zz_n3_expn_1 = ($signed(n3_n2_EXPN) + $signed(10'h0));
  assign _zz_n4_roundUnit_0_o_mtsa = (n4_roundUnit_0_mtsa_clip + 24'h000001);
  assign _zz_n4_roundUnit_0_o_expn = ($signed(n4_n3_EXPN) + $signed(10'h001));
  assign _zz_n4_roundUnit_1_o_mtsa = (n4_roundUnit_1_mtsa_clip + 11'h001);
  assign _zz_n4_roundUnit_1_o_expn = ($signed(n4_n3_EXPN) + $signed(10'h001));
  assign _zz_n4_MTSA = {13'd0, n4_roundUnit_1_o_mtsa};
  `ifndef SYNTHESIS
  always @(*) begin
    case(n4_n1_FLAG)
      FpFlag_ZERO : n4_n1_FLAG_string = "ZERO";
      FpFlag_NORM : n4_n1_FLAG_string = "NORM";
      FpFlag_INF : n4_n1_FLAG_string = "INF ";
      FpFlag_NAN : n4_n1_FLAG_string = "NAN ";
      default : n4_n1_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(n3_n1_FLAG)
      FpFlag_ZERO : n3_n1_FLAG_string = "ZERO";
      FpFlag_NORM : n3_n1_FLAG_string = "NORM";
      FpFlag_INF : n3_n1_FLAG_string = "INF ";
      FpFlag_NAN : n3_n1_FLAG_string = "NAN ";
      default : n3_n1_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_FLAG)
      FpFlag_ZERO : n2_n1_FLAG_string = "ZERO";
      FpFlag_NORM : n2_n1_FLAG_string = "NORM";
      FpFlag_INF : n2_n1_FLAG_string = "INF ";
      FpFlag_NAN : n2_n1_FLAG_string = "NAN ";
      default : n2_n1_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(n5_n1_FLAG)
      FpFlag_ZERO : n5_n1_FLAG_string = "ZERO";
      FpFlag_NORM : n5_n1_FLAG_string = "NORM";
      FpFlag_INF : n5_n1_FLAG_string = "INF ";
      FpFlag_NAN : n5_n1_FLAG_string = "NAN ";
      default : n5_n1_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_FLAG)
      FpFlag_ZERO : n1_FLAG_string = "ZERO";
      FpFlag_NORM : n1_FLAG_string = "NORM";
      FpFlag_INF : n1_FLAG_string = "INF ";
      FpFlag_NAN : n1_FLAG_string = "NAN ";
      default : n1_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(io_i_flag)
      FpFlag_ZERO : io_i_flag_string = "ZERO";
      FpFlag_NORM : io_i_flag_string = "NORM";
      FpFlag_INF : io_i_flag_string = "INF ";
      FpFlag_NAN : io_i_flag_string = "NAN ";
      default : io_i_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(io_o_flag)
      FpFlag_ZERO : io_o_flag_string = "ZERO";
      FpFlag_NORM : io_o_flag_string = "NORM";
      FpFlag_INF : io_o_flag_string = "INF ";
      FpFlag_NAN : io_o_flag_string = "NAN ";
      default : io_o_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_flag_1)
      FpFlag_ZERO : n1_flag_1_string = "ZERO";
      FpFlag_NORM : n1_flag_1_string = "NORM";
      FpFlag_INF : n1_flag_1_string = "INF ";
      FpFlag_NAN : n1_flag_1_string = "NAN ";
      default : n1_flag_1_string = "????";
    endcase
  end
  `endif

  assign when_normRoundUnit_l31 = (io_i_flag == FpFlag_NORM);
  always @(*) begin
    if(when_normRoundUnit_l31) begin
      n1_sign_1 = io_i_mtsa[55];
    end else begin
      n1_sign_1 = io_i_sign;
    end
  end

  assign when_normRoundUnit_l36 = ((io_i_flag == FpFlag_NORM) && ($signed(io_i_mtsa) == $signed(56'h0)));
  always @(*) begin
    if(when_normRoundUnit_l36) begin
      n1_flag_1 = FpFlag_ZERO;
    end else begin
      n1_flag_1 = io_i_flag;
    end
  end

  assign n1_MTSA = (_zz_n1_MTSA + _zz_n1_MTSA_2);
  assign n1_EXPN = io_i_expn;
  assign n1_SIGN = n1_sign_1;
  assign n1_FLAG = n1_flag_1;
  assign n1_SEL = io_i_sel;
  assign _zz_n2_ldz = {8'h0,n2_n1_MTSA};
  assign _zz_n2_ldz_1 = _zz_n2_ldz[63 : 32];
  assign _zz_n2_ldz_2 = _zz_n2_ldz_1[31 : 16];
  assign _zz_n2_ldz_3 = _zz_n2_ldz_2[15 : 8];
  assign _zz_n2_ldz_4 = _zz_n2_ldz_3[7 : 4];
  assign _zz_n2_ldz_5 = _zz_n2_ldz_4[3 : 2];
  assign _zz_n2_ldz_6 = (~ _zz_n2_ldz_5[1 : 1]);
  assign _zz_n2_ldz_7 = (~ _zz_n2_ldz_5[0 : 0]);
  assign _zz_n2_ldz_8 = {(_zz_n2_ldz_6[0] && _zz_n2_ldz_7[0]),((! _zz_n2_ldz_6[0]) ? 1'b0 : (! _zz_n2_ldz_7[0]))};
  assign _zz_n2_ldz_9 = _zz_n2_ldz_4[1 : 0];
  assign _zz_n2_ldz_10 = (~ _zz_n2_ldz_9[1 : 1]);
  assign _zz_n2_ldz_11 = (~ _zz_n2_ldz_9[0 : 0]);
  assign _zz_n2_ldz_12 = {(_zz_n2_ldz_10[0] && _zz_n2_ldz_11[0]),((! _zz_n2_ldz_10[0]) ? 1'b0 : (! _zz_n2_ldz_11[0]))};
  assign _zz_n2_ldz_13 = {(_zz_n2_ldz_8[1] && _zz_n2_ldz_12[1]),((! _zz_n2_ldz_8[1]) ? {1'b0,_zz_n2_ldz_8[0 : 0]} : {(! _zz_n2_ldz_12[1]),_zz_n2_ldz_12[0 : 0]})};
  assign _zz_n2_ldz_14 = _zz_n2_ldz_3[3 : 0];
  assign _zz_n2_ldz_15 = _zz_n2_ldz_14[3 : 2];
  assign _zz_n2_ldz_16 = (~ _zz_n2_ldz_15[1 : 1]);
  assign _zz_n2_ldz_17 = (~ _zz_n2_ldz_15[0 : 0]);
  assign _zz_n2_ldz_18 = {(_zz_n2_ldz_16[0] && _zz_n2_ldz_17[0]),((! _zz_n2_ldz_16[0]) ? 1'b0 : (! _zz_n2_ldz_17[0]))};
  assign _zz_n2_ldz_19 = _zz_n2_ldz_14[1 : 0];
  assign _zz_n2_ldz_20 = (~ _zz_n2_ldz_19[1 : 1]);
  assign _zz_n2_ldz_21 = (~ _zz_n2_ldz_19[0 : 0]);
  assign _zz_n2_ldz_22 = {(_zz_n2_ldz_20[0] && _zz_n2_ldz_21[0]),((! _zz_n2_ldz_20[0]) ? 1'b0 : (! _zz_n2_ldz_21[0]))};
  assign _zz_n2_ldz_23 = {(_zz_n2_ldz_18[1] && _zz_n2_ldz_22[1]),((! _zz_n2_ldz_18[1]) ? {1'b0,_zz_n2_ldz_18[0 : 0]} : {(! _zz_n2_ldz_22[1]),_zz_n2_ldz_22[0 : 0]})};
  assign _zz_n2_ldz_24 = {(_zz_n2_ldz_13[2] && _zz_n2_ldz_23[2]),((! _zz_n2_ldz_13[2]) ? {1'b0,_zz_n2_ldz_13[1 : 0]} : {(! _zz_n2_ldz_23[2]),_zz_n2_ldz_23[1 : 0]})};
  assign _zz_n2_ldz_25 = _zz_n2_ldz_2[7 : 0];
  assign _zz_n2_ldz_26 = _zz_n2_ldz_25[7 : 4];
  assign _zz_n2_ldz_27 = _zz_n2_ldz_26[3 : 2];
  assign _zz_n2_ldz_28 = (~ _zz_n2_ldz_27[1 : 1]);
  assign _zz_n2_ldz_29 = (~ _zz_n2_ldz_27[0 : 0]);
  assign _zz_n2_ldz_30 = {(_zz_n2_ldz_28[0] && _zz_n2_ldz_29[0]),((! _zz_n2_ldz_28[0]) ? 1'b0 : (! _zz_n2_ldz_29[0]))};
  assign _zz_n2_ldz_31 = _zz_n2_ldz_26[1 : 0];
  assign _zz_n2_ldz_32 = (~ _zz_n2_ldz_31[1 : 1]);
  assign _zz_n2_ldz_33 = (~ _zz_n2_ldz_31[0 : 0]);
  assign _zz_n2_ldz_34 = {(_zz_n2_ldz_32[0] && _zz_n2_ldz_33[0]),((! _zz_n2_ldz_32[0]) ? 1'b0 : (! _zz_n2_ldz_33[0]))};
  assign _zz_n2_ldz_35 = {(_zz_n2_ldz_30[1] && _zz_n2_ldz_34[1]),((! _zz_n2_ldz_30[1]) ? {1'b0,_zz_n2_ldz_30[0 : 0]} : {(! _zz_n2_ldz_34[1]),_zz_n2_ldz_34[0 : 0]})};
  assign _zz_n2_ldz_36 = _zz_n2_ldz_25[3 : 0];
  assign _zz_n2_ldz_37 = _zz_n2_ldz_36[3 : 2];
  assign _zz_n2_ldz_38 = (~ _zz_n2_ldz_37[1 : 1]);
  assign _zz_n2_ldz_39 = (~ _zz_n2_ldz_37[0 : 0]);
  assign _zz_n2_ldz_40 = {(_zz_n2_ldz_38[0] && _zz_n2_ldz_39[0]),((! _zz_n2_ldz_38[0]) ? 1'b0 : (! _zz_n2_ldz_39[0]))};
  assign _zz_n2_ldz_41 = _zz_n2_ldz_36[1 : 0];
  assign _zz_n2_ldz_42 = (~ _zz_n2_ldz_41[1 : 1]);
  assign _zz_n2_ldz_43 = (~ _zz_n2_ldz_41[0 : 0]);
  assign _zz_n2_ldz_44 = {(_zz_n2_ldz_42[0] && _zz_n2_ldz_43[0]),((! _zz_n2_ldz_42[0]) ? 1'b0 : (! _zz_n2_ldz_43[0]))};
  assign _zz_n2_ldz_45 = {(_zz_n2_ldz_40[1] && _zz_n2_ldz_44[1]),((! _zz_n2_ldz_40[1]) ? {1'b0,_zz_n2_ldz_40[0 : 0]} : {(! _zz_n2_ldz_44[1]),_zz_n2_ldz_44[0 : 0]})};
  assign _zz_n2_ldz_46 = {(_zz_n2_ldz_35[2] && _zz_n2_ldz_45[2]),((! _zz_n2_ldz_35[2]) ? {1'b0,_zz_n2_ldz_35[1 : 0]} : {(! _zz_n2_ldz_45[2]),_zz_n2_ldz_45[1 : 0]})};
  assign _zz_n2_ldz_47 = {(_zz_n2_ldz_24[3] && _zz_n2_ldz_46[3]),((! _zz_n2_ldz_24[3]) ? {1'b0,_zz_n2_ldz_24[2 : 0]} : {(! _zz_n2_ldz_46[3]),_zz_n2_ldz_46[2 : 0]})};
  assign _zz_n2_ldz_48 = _zz_n2_ldz_1[15 : 0];
  assign _zz_n2_ldz_49 = _zz_n2_ldz_48[15 : 8];
  assign _zz_n2_ldz_50 = _zz_n2_ldz_49[7 : 4];
  assign _zz_n2_ldz_51 = _zz_n2_ldz_50[3 : 2];
  assign _zz_n2_ldz_52 = (~ _zz_n2_ldz_51[1 : 1]);
  assign _zz_n2_ldz_53 = (~ _zz_n2_ldz_51[0 : 0]);
  assign _zz_n2_ldz_54 = {(_zz_n2_ldz_52[0] && _zz_n2_ldz_53[0]),((! _zz_n2_ldz_52[0]) ? 1'b0 : (! _zz_n2_ldz_53[0]))};
  assign _zz_n2_ldz_55 = _zz_n2_ldz_50[1 : 0];
  assign _zz_n2_ldz_56 = (~ _zz_n2_ldz_55[1 : 1]);
  assign _zz_n2_ldz_57 = (~ _zz_n2_ldz_55[0 : 0]);
  assign _zz_n2_ldz_58 = {(_zz_n2_ldz_56[0] && _zz_n2_ldz_57[0]),((! _zz_n2_ldz_56[0]) ? 1'b0 : (! _zz_n2_ldz_57[0]))};
  assign _zz_n2_ldz_59 = {(_zz_n2_ldz_54[1] && _zz_n2_ldz_58[1]),((! _zz_n2_ldz_54[1]) ? {1'b0,_zz_n2_ldz_54[0 : 0]} : {(! _zz_n2_ldz_58[1]),_zz_n2_ldz_58[0 : 0]})};
  assign _zz_n2_ldz_60 = _zz_n2_ldz_49[3 : 0];
  assign _zz_n2_ldz_61 = _zz_n2_ldz_60[3 : 2];
  assign _zz_n2_ldz_62 = (~ _zz_n2_ldz_61[1 : 1]);
  assign _zz_n2_ldz_63 = (~ _zz_n2_ldz_61[0 : 0]);
  assign _zz_n2_ldz_64 = {(_zz_n2_ldz_62[0] && _zz_n2_ldz_63[0]),((! _zz_n2_ldz_62[0]) ? 1'b0 : (! _zz_n2_ldz_63[0]))};
  assign _zz_n2_ldz_65 = _zz_n2_ldz_60[1 : 0];
  assign _zz_n2_ldz_66 = (~ _zz_n2_ldz_65[1 : 1]);
  assign _zz_n2_ldz_67 = (~ _zz_n2_ldz_65[0 : 0]);
  assign _zz_n2_ldz_68 = {(_zz_n2_ldz_66[0] && _zz_n2_ldz_67[0]),((! _zz_n2_ldz_66[0]) ? 1'b0 : (! _zz_n2_ldz_67[0]))};
  assign _zz_n2_ldz_69 = {(_zz_n2_ldz_64[1] && _zz_n2_ldz_68[1]),((! _zz_n2_ldz_64[1]) ? {1'b0,_zz_n2_ldz_64[0 : 0]} : {(! _zz_n2_ldz_68[1]),_zz_n2_ldz_68[0 : 0]})};
  assign _zz_n2_ldz_70 = {(_zz_n2_ldz_59[2] && _zz_n2_ldz_69[2]),((! _zz_n2_ldz_59[2]) ? {1'b0,_zz_n2_ldz_59[1 : 0]} : {(! _zz_n2_ldz_69[2]),_zz_n2_ldz_69[1 : 0]})};
  assign _zz_n2_ldz_71 = _zz_n2_ldz_48[7 : 0];
  assign _zz_n2_ldz_72 = _zz_n2_ldz_71[7 : 4];
  assign _zz_n2_ldz_73 = _zz_n2_ldz_72[3 : 2];
  assign _zz_n2_ldz_74 = (~ _zz_n2_ldz_73[1 : 1]);
  assign _zz_n2_ldz_75 = (~ _zz_n2_ldz_73[0 : 0]);
  assign _zz_n2_ldz_76 = {(_zz_n2_ldz_74[0] && _zz_n2_ldz_75[0]),((! _zz_n2_ldz_74[0]) ? 1'b0 : (! _zz_n2_ldz_75[0]))};
  assign _zz_n2_ldz_77 = _zz_n2_ldz_72[1 : 0];
  assign _zz_n2_ldz_78 = (~ _zz_n2_ldz_77[1 : 1]);
  assign _zz_n2_ldz_79 = (~ _zz_n2_ldz_77[0 : 0]);
  assign _zz_n2_ldz_80 = {(_zz_n2_ldz_78[0] && _zz_n2_ldz_79[0]),((! _zz_n2_ldz_78[0]) ? 1'b0 : (! _zz_n2_ldz_79[0]))};
  assign _zz_n2_ldz_81 = {(_zz_n2_ldz_76[1] && _zz_n2_ldz_80[1]),((! _zz_n2_ldz_76[1]) ? {1'b0,_zz_n2_ldz_76[0 : 0]} : {(! _zz_n2_ldz_80[1]),_zz_n2_ldz_80[0 : 0]})};
  assign _zz_n2_ldz_82 = _zz_n2_ldz_71[3 : 0];
  assign _zz_n2_ldz_83 = _zz_n2_ldz_82[3 : 2];
  assign _zz_n2_ldz_84 = (~ _zz_n2_ldz_83[1 : 1]);
  assign _zz_n2_ldz_85 = (~ _zz_n2_ldz_83[0 : 0]);
  assign _zz_n2_ldz_86 = {(_zz_n2_ldz_84[0] && _zz_n2_ldz_85[0]),((! _zz_n2_ldz_84[0]) ? 1'b0 : (! _zz_n2_ldz_85[0]))};
  assign _zz_n2_ldz_87 = _zz_n2_ldz_82[1 : 0];
  assign _zz_n2_ldz_88 = (~ _zz_n2_ldz_87[1 : 1]);
  assign _zz_n2_ldz_89 = (~ _zz_n2_ldz_87[0 : 0]);
  assign _zz_n2_ldz_90 = {(_zz_n2_ldz_88[0] && _zz_n2_ldz_89[0]),((! _zz_n2_ldz_88[0]) ? 1'b0 : (! _zz_n2_ldz_89[0]))};
  assign _zz_n2_ldz_91 = {(_zz_n2_ldz_86[1] && _zz_n2_ldz_90[1]),((! _zz_n2_ldz_86[1]) ? {1'b0,_zz_n2_ldz_86[0 : 0]} : {(! _zz_n2_ldz_90[1]),_zz_n2_ldz_90[0 : 0]})};
  assign _zz_n2_ldz_92 = {(_zz_n2_ldz_81[2] && _zz_n2_ldz_91[2]),((! _zz_n2_ldz_81[2]) ? {1'b0,_zz_n2_ldz_81[1 : 0]} : {(! _zz_n2_ldz_91[2]),_zz_n2_ldz_91[1 : 0]})};
  assign _zz_n2_ldz_93 = {(_zz_n2_ldz_70[3] && _zz_n2_ldz_92[3]),((! _zz_n2_ldz_70[3]) ? {1'b0,_zz_n2_ldz_70[2 : 0]} : {(! _zz_n2_ldz_92[3]),_zz_n2_ldz_92[2 : 0]})};
  assign _zz_n2_ldz_94 = {(_zz_n2_ldz_47[4] && _zz_n2_ldz_93[4]),((! _zz_n2_ldz_47[4]) ? {1'b0,_zz_n2_ldz_47[3 : 0]} : {(! _zz_n2_ldz_93[4]),_zz_n2_ldz_93[3 : 0]})};
  assign _zz_n2_ldz_95 = _zz_n2_ldz[31 : 0];
  assign _zz_n2_ldz_96 = _zz_n2_ldz_95[31 : 16];
  assign _zz_n2_ldz_97 = _zz_n2_ldz_96[15 : 8];
  assign _zz_n2_ldz_98 = _zz_n2_ldz_97[7 : 4];
  assign _zz_n2_ldz_99 = _zz_n2_ldz_98[3 : 2];
  assign _zz_n2_ldz_100 = (~ _zz_n2_ldz_99[1 : 1]);
  assign _zz_n2_ldz_101 = (~ _zz_n2_ldz_99[0 : 0]);
  assign _zz_n2_ldz_102 = {(_zz_n2_ldz_100[0] && _zz_n2_ldz_101[0]),((! _zz_n2_ldz_100[0]) ? 1'b0 : (! _zz_n2_ldz_101[0]))};
  assign _zz_n2_ldz_103 = _zz_n2_ldz_98[1 : 0];
  assign _zz_n2_ldz_104 = (~ _zz_n2_ldz_103[1 : 1]);
  assign _zz_n2_ldz_105 = (~ _zz_n2_ldz_103[0 : 0]);
  assign _zz_n2_ldz_106 = {(_zz_n2_ldz_104[0] && _zz_n2_ldz_105[0]),((! _zz_n2_ldz_104[0]) ? 1'b0 : (! _zz_n2_ldz_105[0]))};
  assign _zz_n2_ldz_107 = {(_zz_n2_ldz_102[1] && _zz_n2_ldz_106[1]),((! _zz_n2_ldz_102[1]) ? {1'b0,_zz_n2_ldz_102[0 : 0]} : {(! _zz_n2_ldz_106[1]),_zz_n2_ldz_106[0 : 0]})};
  assign _zz_n2_ldz_108 = _zz_n2_ldz_97[3 : 0];
  assign _zz_n2_ldz_109 = _zz_n2_ldz_108[3 : 2];
  assign _zz_n2_ldz_110 = (~ _zz_n2_ldz_109[1 : 1]);
  assign _zz_n2_ldz_111 = (~ _zz_n2_ldz_109[0 : 0]);
  assign _zz_n2_ldz_112 = {(_zz_n2_ldz_110[0] && _zz_n2_ldz_111[0]),((! _zz_n2_ldz_110[0]) ? 1'b0 : (! _zz_n2_ldz_111[0]))};
  assign _zz_n2_ldz_113 = _zz_n2_ldz_108[1 : 0];
  assign _zz_n2_ldz_114 = (~ _zz_n2_ldz_113[1 : 1]);
  assign _zz_n2_ldz_115 = (~ _zz_n2_ldz_113[0 : 0]);
  assign _zz_n2_ldz_116 = {(_zz_n2_ldz_114[0] && _zz_n2_ldz_115[0]),((! _zz_n2_ldz_114[0]) ? 1'b0 : (! _zz_n2_ldz_115[0]))};
  assign _zz_n2_ldz_117 = {(_zz_n2_ldz_112[1] && _zz_n2_ldz_116[1]),((! _zz_n2_ldz_112[1]) ? {1'b0,_zz_n2_ldz_112[0 : 0]} : {(! _zz_n2_ldz_116[1]),_zz_n2_ldz_116[0 : 0]})};
  assign _zz_n2_ldz_118 = {(_zz_n2_ldz_107[2] && _zz_n2_ldz_117[2]),((! _zz_n2_ldz_107[2]) ? {1'b0,_zz_n2_ldz_107[1 : 0]} : {(! _zz_n2_ldz_117[2]),_zz_n2_ldz_117[1 : 0]})};
  assign _zz_n2_ldz_119 = _zz_n2_ldz_96[7 : 0];
  assign _zz_n2_ldz_120 = _zz_n2_ldz_119[7 : 4];
  assign _zz_n2_ldz_121 = _zz_n2_ldz_120[3 : 2];
  assign _zz_n2_ldz_122 = (~ _zz_n2_ldz_121[1 : 1]);
  assign _zz_n2_ldz_123 = (~ _zz_n2_ldz_121[0 : 0]);
  assign _zz_n2_ldz_124 = {(_zz_n2_ldz_122[0] && _zz_n2_ldz_123[0]),((! _zz_n2_ldz_122[0]) ? 1'b0 : (! _zz_n2_ldz_123[0]))};
  assign _zz_n2_ldz_125 = _zz_n2_ldz_120[1 : 0];
  assign _zz_n2_ldz_126 = (~ _zz_n2_ldz_125[1 : 1]);
  assign _zz_n2_ldz_127 = (~ _zz_n2_ldz_125[0 : 0]);
  assign _zz_n2_ldz_128 = {(_zz_n2_ldz_126[0] && _zz_n2_ldz_127[0]),((! _zz_n2_ldz_126[0]) ? 1'b0 : (! _zz_n2_ldz_127[0]))};
  assign _zz_n2_ldz_129 = {(_zz_n2_ldz_124[1] && _zz_n2_ldz_128[1]),((! _zz_n2_ldz_124[1]) ? {1'b0,_zz_n2_ldz_124[0 : 0]} : {(! _zz_n2_ldz_128[1]),_zz_n2_ldz_128[0 : 0]})};
  assign _zz_n2_ldz_130 = _zz_n2_ldz_119[3 : 0];
  assign _zz_n2_ldz_131 = _zz_n2_ldz_130[3 : 2];
  assign _zz_n2_ldz_132 = (~ _zz_n2_ldz_131[1 : 1]);
  assign _zz_n2_ldz_133 = (~ _zz_n2_ldz_131[0 : 0]);
  assign _zz_n2_ldz_134 = {(_zz_n2_ldz_132[0] && _zz_n2_ldz_133[0]),((! _zz_n2_ldz_132[0]) ? 1'b0 : (! _zz_n2_ldz_133[0]))};
  assign _zz_n2_ldz_135 = _zz_n2_ldz_130[1 : 0];
  assign _zz_n2_ldz_136 = (~ _zz_n2_ldz_135[1 : 1]);
  assign _zz_n2_ldz_137 = (~ _zz_n2_ldz_135[0 : 0]);
  assign _zz_n2_ldz_138 = {(_zz_n2_ldz_136[0] && _zz_n2_ldz_137[0]),((! _zz_n2_ldz_136[0]) ? 1'b0 : (! _zz_n2_ldz_137[0]))};
  assign _zz_n2_ldz_139 = {(_zz_n2_ldz_134[1] && _zz_n2_ldz_138[1]),((! _zz_n2_ldz_134[1]) ? {1'b0,_zz_n2_ldz_134[0 : 0]} : {(! _zz_n2_ldz_138[1]),_zz_n2_ldz_138[0 : 0]})};
  assign _zz_n2_ldz_140 = {(_zz_n2_ldz_129[2] && _zz_n2_ldz_139[2]),((! _zz_n2_ldz_129[2]) ? {1'b0,_zz_n2_ldz_129[1 : 0]} : {(! _zz_n2_ldz_139[2]),_zz_n2_ldz_139[1 : 0]})};
  assign _zz_n2_ldz_141 = {(_zz_n2_ldz_118[3] && _zz_n2_ldz_140[3]),((! _zz_n2_ldz_118[3]) ? {1'b0,_zz_n2_ldz_118[2 : 0]} : {(! _zz_n2_ldz_140[3]),_zz_n2_ldz_140[2 : 0]})};
  assign _zz_n2_ldz_142 = _zz_n2_ldz_95[15 : 0];
  assign _zz_n2_ldz_143 = _zz_n2_ldz_142[15 : 8];
  assign _zz_n2_ldz_144 = _zz_n2_ldz_143[7 : 4];
  assign _zz_n2_ldz_145 = _zz_n2_ldz_144[3 : 2];
  assign _zz_n2_ldz_146 = (~ _zz_n2_ldz_145[1 : 1]);
  assign _zz_n2_ldz_147 = (~ _zz_n2_ldz_145[0 : 0]);
  assign _zz_n2_ldz_148 = {(_zz_n2_ldz_146[0] && _zz_n2_ldz_147[0]),((! _zz_n2_ldz_146[0]) ? 1'b0 : (! _zz_n2_ldz_147[0]))};
  assign _zz_n2_ldz_149 = _zz_n2_ldz_144[1 : 0];
  assign _zz_n2_ldz_150 = (~ _zz_n2_ldz_149[1 : 1]);
  assign _zz_n2_ldz_151 = (~ _zz_n2_ldz_149[0 : 0]);
  assign _zz_n2_ldz_152 = {(_zz_n2_ldz_150[0] && _zz_n2_ldz_151[0]),((! _zz_n2_ldz_150[0]) ? 1'b0 : (! _zz_n2_ldz_151[0]))};
  assign _zz_n2_ldz_153 = {(_zz_n2_ldz_148[1] && _zz_n2_ldz_152[1]),((! _zz_n2_ldz_148[1]) ? {1'b0,_zz_n2_ldz_148[0 : 0]} : {(! _zz_n2_ldz_152[1]),_zz_n2_ldz_152[0 : 0]})};
  assign _zz_n2_ldz_154 = _zz_n2_ldz_143[3 : 0];
  assign _zz_n2_ldz_155 = _zz_n2_ldz_154[3 : 2];
  assign _zz_n2_ldz_156 = (~ _zz_n2_ldz_155[1 : 1]);
  assign _zz_n2_ldz_157 = (~ _zz_n2_ldz_155[0 : 0]);
  assign _zz_n2_ldz_158 = {(_zz_n2_ldz_156[0] && _zz_n2_ldz_157[0]),((! _zz_n2_ldz_156[0]) ? 1'b0 : (! _zz_n2_ldz_157[0]))};
  assign _zz_n2_ldz_159 = _zz_n2_ldz_154[1 : 0];
  assign _zz_n2_ldz_160 = (~ _zz_n2_ldz_159[1 : 1]);
  assign _zz_n2_ldz_161 = (~ _zz_n2_ldz_159[0 : 0]);
  assign _zz_n2_ldz_162 = {(_zz_n2_ldz_160[0] && _zz_n2_ldz_161[0]),((! _zz_n2_ldz_160[0]) ? 1'b0 : (! _zz_n2_ldz_161[0]))};
  assign _zz_n2_ldz_163 = {(_zz_n2_ldz_158[1] && _zz_n2_ldz_162[1]),((! _zz_n2_ldz_158[1]) ? {1'b0,_zz_n2_ldz_158[0 : 0]} : {(! _zz_n2_ldz_162[1]),_zz_n2_ldz_162[0 : 0]})};
  assign _zz_n2_ldz_164 = {(_zz_n2_ldz_153[2] && _zz_n2_ldz_163[2]),((! _zz_n2_ldz_153[2]) ? {1'b0,_zz_n2_ldz_153[1 : 0]} : {(! _zz_n2_ldz_163[2]),_zz_n2_ldz_163[1 : 0]})};
  assign _zz_n2_ldz_165 = _zz_n2_ldz_142[7 : 0];
  assign _zz_n2_ldz_166 = _zz_n2_ldz_165[7 : 4];
  assign _zz_n2_ldz_167 = _zz_n2_ldz_166[3 : 2];
  assign _zz_n2_ldz_168 = (~ _zz_n2_ldz_167[1 : 1]);
  assign _zz_n2_ldz_169 = (~ _zz_n2_ldz_167[0 : 0]);
  assign _zz_n2_ldz_170 = {(_zz_n2_ldz_168[0] && _zz_n2_ldz_169[0]),((! _zz_n2_ldz_168[0]) ? 1'b0 : (! _zz_n2_ldz_169[0]))};
  assign _zz_n2_ldz_171 = _zz_n2_ldz_166[1 : 0];
  assign _zz_n2_ldz_172 = (~ _zz_n2_ldz_171[1 : 1]);
  assign _zz_n2_ldz_173 = (~ _zz_n2_ldz_171[0 : 0]);
  assign _zz_n2_ldz_174 = {(_zz_n2_ldz_172[0] && _zz_n2_ldz_173[0]),((! _zz_n2_ldz_172[0]) ? 1'b0 : (! _zz_n2_ldz_173[0]))};
  assign _zz_n2_ldz_175 = {(_zz_n2_ldz_170[1] && _zz_n2_ldz_174[1]),((! _zz_n2_ldz_170[1]) ? {1'b0,_zz_n2_ldz_170[0 : 0]} : {(! _zz_n2_ldz_174[1]),_zz_n2_ldz_174[0 : 0]})};
  assign _zz_n2_ldz_176 = _zz_n2_ldz_165[3 : 0];
  assign _zz_n2_ldz_177 = _zz_n2_ldz_176[3 : 2];
  assign _zz_n2_ldz_178 = (~ _zz_n2_ldz_177[1 : 1]);
  assign _zz_n2_ldz_179 = (~ _zz_n2_ldz_177[0 : 0]);
  assign _zz_n2_ldz_180 = {(_zz_n2_ldz_178[0] && _zz_n2_ldz_179[0]),((! _zz_n2_ldz_178[0]) ? 1'b0 : (! _zz_n2_ldz_179[0]))};
  assign _zz_n2_ldz_181 = _zz_n2_ldz_176[1 : 0];
  assign _zz_n2_ldz_182 = (~ _zz_n2_ldz_181[1 : 1]);
  assign _zz_n2_ldz_183 = (~ _zz_n2_ldz_181[0 : 0]);
  assign _zz_n2_ldz_184 = {(_zz_n2_ldz_182[0] && _zz_n2_ldz_183[0]),((! _zz_n2_ldz_182[0]) ? 1'b0 : (! _zz_n2_ldz_183[0]))};
  assign _zz_n2_ldz_185 = {(_zz_n2_ldz_180[1] && _zz_n2_ldz_184[1]),((! _zz_n2_ldz_180[1]) ? {1'b0,_zz_n2_ldz_180[0 : 0]} : {(! _zz_n2_ldz_184[1]),_zz_n2_ldz_184[0 : 0]})};
  assign _zz_n2_ldz_186 = {(_zz_n2_ldz_175[2] && _zz_n2_ldz_185[2]),((! _zz_n2_ldz_175[2]) ? {1'b0,_zz_n2_ldz_175[1 : 0]} : {(! _zz_n2_ldz_185[2]),_zz_n2_ldz_185[1 : 0]})};
  assign _zz_n2_ldz_187 = {(_zz_n2_ldz_164[3] && _zz_n2_ldz_186[3]),((! _zz_n2_ldz_164[3]) ? {1'b0,_zz_n2_ldz_164[2 : 0]} : {(! _zz_n2_ldz_186[3]),_zz_n2_ldz_186[2 : 0]})};
  assign _zz_n2_ldz_188 = {(_zz_n2_ldz_141[4] && _zz_n2_ldz_187[4]),((! _zz_n2_ldz_141[4]) ? {1'b0,_zz_n2_ldz_141[3 : 0]} : {(! _zz_n2_ldz_187[4]),_zz_n2_ldz_187[3 : 0]})};
  assign n2_ldz = ({(_zz_n2_ldz_94[5] && _zz_n2_ldz_188[5]),((! _zz_n2_ldz_94[5]) ? {1'b0,_zz_n2_ldz_94[4 : 0]} : {(! _zz_n2_ldz_188[5]),_zz_n2_ldz_188[4 : 0]})} - 7'h08);
  assign n2_adj = (n2_n1_SEL ? 4'b0111 : 4'b0111);
  assign n2_expn_1 = ($signed(_zz_n2_expn_1) - $signed(_zz_n2_expn_1_2));
  assign n2_mtsa_1 = (n2_n1_MTSA <<< n2_ldz);
  assign n2_MTSA = n2_mtsa_1;
  assign n2_EXPN = n2_expn_1;
  assign n3_rsh = (($signed(n3_n2_EXPN) < $signed(10'h001)) ? _zz_n3_rsh : 10'h0);
  assign n3_expn_1 = (($signed(n3_n2_EXPN) < $signed(10'h001)) ? 10'h001 : _zz_n3_expn_1);
  assign n3_mtsa_1 = (n3_n2_MTSA >>> n3_rsh);
  assign n3_MTSA = n3_mtsa_1;
  assign n3_EXPN = n3_expn_1;
  assign n4_roundUnit_0_mtsa_clip = n4_n3_MTSA[55 : 32];
  assign n4_roundUnit_0_round_bit = n4_n3_MTSA[31];
  assign n4_roundUnit_0_stick_bit = n4_n3_MTSA[30 : 0];
  assign n4_roundUnit_0_cond = (n4_roundUnit_0_round_bit && ((|n4_roundUnit_0_stick_bit) || n4_roundUnit_0_mtsa_clip[0]));
  always @(*) begin
    if(n4_roundUnit_0_cond) begin
      n4_roundUnit_0_o_mtsa = ((&n4_roundUnit_0_mtsa_clip) ? 24'h800000 : _zz_n4_roundUnit_0_o_mtsa);
    end else begin
      n4_roundUnit_0_o_mtsa = n4_roundUnit_0_mtsa_clip;
    end
  end

  always @(*) begin
    if(n4_roundUnit_0_cond) begin
      n4_roundUnit_0_o_expn = ((&n4_roundUnit_0_mtsa_clip) ? _zz_n4_roundUnit_0_o_expn : n4_n3_EXPN);
    end else begin
      n4_roundUnit_0_o_expn = n4_n3_EXPN;
    end
  end

  assign n4_roundUnit_1_mtsa_clip = n4_n3_MTSA[55 : 45];
  assign n4_roundUnit_1_round_bit = n4_n3_MTSA[44];
  assign n4_roundUnit_1_stick_bit = n4_n3_MTSA[43 : 0];
  assign n4_roundUnit_1_cond = (n4_roundUnit_1_round_bit && ((|n4_roundUnit_1_stick_bit) || n4_roundUnit_1_mtsa_clip[0]));
  always @(*) begin
    if(n4_roundUnit_1_cond) begin
      n4_roundUnit_1_o_mtsa = ((&n4_roundUnit_1_mtsa_clip) ? 11'h400 : _zz_n4_roundUnit_1_o_mtsa);
    end else begin
      n4_roundUnit_1_o_mtsa = n4_roundUnit_1_mtsa_clip;
    end
  end

  always @(*) begin
    if(n4_roundUnit_1_cond) begin
      n4_roundUnit_1_o_expn = ((&n4_roundUnit_1_mtsa_clip) ? _zz_n4_roundUnit_1_o_expn : n4_n3_EXPN);
    end else begin
      n4_roundUnit_1_o_expn = n4_n3_EXPN;
    end
  end

  assign n4_MTSA = (n4_n1_SEL ? _zz_n4_MTSA : n4_roundUnit_0_o_mtsa);
  assign n4_EXPN = (n4_n1_SEL ? n4_roundUnit_1_o_expn : n4_roundUnit_0_o_expn);
  assign io_o_mtsa = n5_n4_MTSA;
  assign io_o_expn = n5_n4_EXPN;
  assign io_o_sign = n5_n1_SIGN;
  assign io_o_flag = n5_n1_FLAG;
  always @(posedge clk) begin
    n2_n1_MTSA <= n1_MTSA;
    n2_n1_EXPN <= n1_EXPN;
    n2_n1_SIGN <= n1_SIGN;
    n2_n1_FLAG <= n1_FLAG;
    n2_n1_SEL <= n1_SEL;
    n3_n1_SIGN <= n2_n1_SIGN;
    n3_n1_FLAG <= n2_n1_FLAG;
    n3_n1_SEL <= n2_n1_SEL;
    n3_n2_MTSA <= n2_MTSA;
    n3_n2_EXPN <= n2_EXPN;
    n4_n1_SIGN <= n3_n1_SIGN;
    n4_n1_FLAG <= n3_n1_FLAG;
    n4_n1_SEL <= n3_n1_SEL;
    n4_n3_MTSA <= n3_MTSA;
    n4_n3_EXPN <= n3_EXPN;
    n5_n1_SIGN <= n4_n1_SIGN;
    n5_n1_FLAG <= n4_n1_FLAG;
    n5_n4_MTSA <= n4_MTSA;
    n5_n4_EXPN <= n4_EXPN;
  end


endmodule

//adderTree_1 replaced by adderTree

module adderTree (
  input  wire [55:0]   io_i_data_0,
  input  wire [55:0]   io_i_data_1,
  input  wire [55:0]   io_i_data_2,
  input  wire [55:0]   io_i_data_3,
  input  wire [55:0]   io_i_data_4,
  input  wire [55:0]   io_i_data_5,
  input  wire [55:0]   io_i_data_6,
  input  wire [55:0]   io_i_data_7,
  input  wire [55:0]   io_i_data_8,
  input  wire [55:0]   io_i_data_9,
  input  wire [55:0]   io_i_data_10,
  input  wire [55:0]   io_i_data_11,
  input  wire [55:0]   io_i_data_12,
  input  wire [55:0]   io_i_data_13,
  input  wire [55:0]   io_i_data_14,
  input  wire [55:0]   io_i_data_15,
  input  wire [55:0]   io_i_data_16,
  output wire [55:0]   io_o_data,
  input  wire          clk,
  input  wire          resetn
);

  wire       [55:0]   _zz_n1_m_data_0;
  wire       [55:0]   _zz_n1_m_data_1;
  wire       [55:0]   _zz_n1_m_data_2;
  wire       [55:0]   _zz_n1_m_data_3;
  wire       [55:0]   _zz_n1_m_data_4;
  wire       [55:0]   _zz_n2_m_data_0;
  wire       [55:0]   _zz_n2_m_data_1;
  reg        [55:0]   n4_n3_DATA;
  wire       [55:0]   n3_DATA;
  reg        [55:0]   n3_n2_DATA_0;
  reg        [55:0]   n3_n2_DATA_1;
  wire       [55:0]   n2_DATA_0;
  wire       [55:0]   n2_DATA_1;
  reg        [55:0]   n2_n1_DATA_0;
  reg        [55:0]   n2_n1_DATA_1;
  reg        [55:0]   n2_n1_DATA_2;
  reg        [55:0]   n2_n1_DATA_3;
  reg        [55:0]   n2_n1_DATA_4;
  reg        [55:0]   n2_n1_DATA_5;
  wire       [55:0]   n1_DATA_0;
  wire       [55:0]   n1_DATA_1;
  wire       [55:0]   n1_DATA_2;
  wire       [55:0]   n1_DATA_3;
  wire       [55:0]   n1_DATA_4;
  wire       [55:0]   n1_DATA_5;
  wire       [55:0]   n1_m_data_0;
  wire       [55:0]   n1_m_data_1;
  wire       [55:0]   n1_m_data_2;
  wire       [55:0]   n1_m_data_3;
  wire       [55:0]   n1_m_data_4;
  wire       [55:0]   n1_m_data_5;
  wire       [55:0]   n2_m_data_0;
  wire       [55:0]   n2_m_data_1;
  wire       [55:0]   n3_m_data;

  assign _zz_n1_m_data_0 = ($signed(io_i_data_0) + $signed(io_i_data_1));
  assign _zz_n1_m_data_1 = ($signed(io_i_data_3) + $signed(io_i_data_4));
  assign _zz_n1_m_data_2 = ($signed(io_i_data_6) + $signed(io_i_data_7));
  assign _zz_n1_m_data_3 = ($signed(io_i_data_9) + $signed(io_i_data_10));
  assign _zz_n1_m_data_4 = ($signed(io_i_data_12) + $signed(io_i_data_13));
  assign _zz_n2_m_data_0 = ($signed(n2_n1_DATA_0) + $signed(n2_n1_DATA_1));
  assign _zz_n2_m_data_1 = ($signed(n2_n1_DATA_3) + $signed(n2_n1_DATA_4));
  assign n1_m_data_0 = ($signed(_zz_n1_m_data_0) + $signed(io_i_data_2));
  assign n1_m_data_1 = ($signed(_zz_n1_m_data_1) + $signed(io_i_data_5));
  assign n1_m_data_2 = ($signed(_zz_n1_m_data_2) + $signed(io_i_data_8));
  assign n1_m_data_3 = ($signed(_zz_n1_m_data_3) + $signed(io_i_data_11));
  assign n1_m_data_4 = ($signed(_zz_n1_m_data_4) + $signed(io_i_data_14));
  assign n1_m_data_5 = ($signed(io_i_data_15) + $signed(io_i_data_16));
  assign n1_DATA_0 = n1_m_data_0;
  assign n1_DATA_1 = n1_m_data_1;
  assign n1_DATA_2 = n1_m_data_2;
  assign n1_DATA_3 = n1_m_data_3;
  assign n1_DATA_4 = n1_m_data_4;
  assign n1_DATA_5 = n1_m_data_5;
  assign n2_m_data_0 = ($signed(_zz_n2_m_data_0) + $signed(n2_n1_DATA_2));
  assign n2_m_data_1 = ($signed(_zz_n2_m_data_1) + $signed(n2_n1_DATA_5));
  assign n2_DATA_0 = n2_m_data_0;
  assign n2_DATA_1 = n2_m_data_1;
  assign n3_m_data = ($signed(n3_n2_DATA_0) + $signed(n3_n2_DATA_1));
  assign n3_DATA = n3_m_data;
  assign io_o_data = n4_n3_DATA;
  always @(posedge clk) begin
    n2_n1_DATA_0 <= n1_DATA_0;
    n2_n1_DATA_1 <= n1_DATA_1;
    n2_n1_DATA_2 <= n1_DATA_2;
    n2_n1_DATA_3 <= n1_DATA_3;
    n2_n1_DATA_4 <= n1_DATA_4;
    n2_n1_DATA_5 <= n1_DATA_5;
    n3_n2_DATA_0 <= n2_DATA_0;
    n3_n2_DATA_1 <= n2_DATA_1;
    n4_n3_DATA <= n3_DATA;
  end


endmodule

//FPalignUnit_33 replaced by FPalignUnit_32

module FPalignUnit_32 (
  input  wire          io_i_sel,
  input  wire [23:0]   io_i_mtsa,
  input  wire          io_i_sign,
  input  wire [9:0]    io_i_nrsh,
  output wire [55:0]   io_o_mtsa,
  input  wire          clk,
  input  wire          resetn
);

  wire       [55:0]   _zz_n1_s_mtsa;
  wire       [55:0]   _zz_n2_o_mtsa;
  wire       [55:0]   _zz_n2_o_mtsa_1;
  reg        [55:0]   n3_n2_MTSA;
  wire       [55:0]   n2_MTSA;
  reg        [55:0]   n2_n1_MTSA;
  reg                 n2_n1_SIGN;
  wire                n1_SIGN;
  wire       [55:0]   n1_MTSA;
  wire       [55:0]   n1_e0_mtsa;
  wire       [55:0]   n1_e1_mtsa;
  wire       [55:0]   n1_e_mtsa;
  wire       [55:0]   n1_s_mtsa;
  wire       [55:0]   n2_o_mtsa;

  assign _zz_n1_s_mtsa = n1_e_mtsa;
  assign _zz_n2_o_mtsa = (- n2_n1_MTSA);
  assign _zz_n2_o_mtsa_1 = ($signed(n2_n1_MTSA) + $signed(56'h0));
  assign n1_e0_mtsa = {{7'h0,io_i_mtsa[23 : 0]},25'h0};
  assign n1_e1_mtsa = {{7'h0,io_i_mtsa[11 : 0]},37'h0};
  assign n1_e_mtsa = (io_i_sel ? n1_e1_mtsa : n1_e0_mtsa);
  assign n1_s_mtsa = ($signed(_zz_n1_s_mtsa) >>> io_i_nrsh);
  assign n1_MTSA = n1_s_mtsa;
  assign n1_SIGN = io_i_sign;
  assign n2_o_mtsa = (n2_n1_SIGN ? _zz_n2_o_mtsa : _zz_n2_o_mtsa_1);
  assign n2_MTSA = n2_o_mtsa;
  assign io_o_mtsa = n3_n2_MTSA;
  always @(posedge clk) begin
    n2_n1_MTSA <= n1_MTSA;
    n2_n1_SIGN <= n1_SIGN;
    n3_n2_MTSA <= n2_MTSA;
  end


endmodule

//FPalignUnit_31 replaced by FPalignUnit

//FPalignUnit_30 replaced by FPalignUnit

//FPalignUnit_29 replaced by FPalignUnit

//FPalignUnit_28 replaced by FPalignUnit

//FPalignUnit_27 replaced by FPalignUnit

//FPalignUnit_26 replaced by FPalignUnit

//FPalignUnit_25 replaced by FPalignUnit

//FPalignUnit_24 replaced by FPalignUnit

//FPalignUnit_23 replaced by FPalignUnit

//FPalignUnit_22 replaced by FPalignUnit

//FPalignUnit_21 replaced by FPalignUnit

//FPalignUnit_20 replaced by FPalignUnit

//FPalignUnit_19 replaced by FPalignUnit

//FPalignUnit_18 replaced by FPalignUnit

//FPalignUnit_17 replaced by FPalignUnit

//FPalignUnit_16 replaced by FPalignUnit

//FPalignUnit_15 replaced by FPalignUnit

//FPalignUnit_14 replaced by FPalignUnit

//FPalignUnit_13 replaced by FPalignUnit

//FPalignUnit_12 replaced by FPalignUnit

//FPalignUnit_11 replaced by FPalignUnit

//FPalignUnit_10 replaced by FPalignUnit

//FPalignUnit_9 replaced by FPalignUnit

//FPalignUnit_8 replaced by FPalignUnit

//FPalignUnit_7 replaced by FPalignUnit

//FPalignUnit_6 replaced by FPalignUnit

//FPalignUnit_5 replaced by FPalignUnit

//FPalignUnit_4 replaced by FPalignUnit

//FPalignUnit_3 replaced by FPalignUnit

//FPalignUnit_2 replaced by FPalignUnit

//FPalignUnit_1 replaced by FPalignUnit

module FPalignUnit (
  input  wire          io_i_sel,
  input  wire [47:0]   io_i_mtsa,
  input  wire          io_i_sign,
  input  wire [9:0]    io_i_nrsh,
  output wire [55:0]   io_o_mtsa,
  input  wire          clk,
  input  wire          resetn
);

  wire       [55:0]   _zz_n1_s_mtsa;
  wire       [55:0]   _zz_n2_o_mtsa;
  wire       [55:0]   _zz_n2_o_mtsa_1;
  reg        [55:0]   n3_n2_MTSA;
  wire       [55:0]   n2_MTSA;
  reg        [55:0]   n2_n1_MTSA;
  reg                 n2_n1_SIGN;
  wire                n1_SIGN;
  wire       [55:0]   n1_MTSA;
  wire       [55:0]   n1_e0_mtsa;
  wire       [55:0]   n1_e1_mtsa;
  wire       [55:0]   n1_e_mtsa;
  wire       [55:0]   n1_s_mtsa;
  wire       [55:0]   n2_o_mtsa;

  assign _zz_n1_s_mtsa = n1_e_mtsa;
  assign _zz_n2_o_mtsa = (- n2_n1_MTSA);
  assign _zz_n2_o_mtsa_1 = ($signed(n2_n1_MTSA) + $signed(56'h0));
  assign n1_e0_mtsa = {{6'h0,io_i_mtsa[47 : 0]},2'b00};
  assign n1_e1_mtsa = {{6'h0,io_i_mtsa[23 : 0]},26'h0};
  assign n1_e_mtsa = (io_i_sel ? n1_e1_mtsa : n1_e0_mtsa);
  assign n1_s_mtsa = ($signed(_zz_n1_s_mtsa) >>> io_i_nrsh);
  assign n1_MTSA = n1_s_mtsa;
  assign n1_SIGN = io_i_sign;
  assign n2_o_mtsa = (n2_n1_SIGN ? _zz_n2_o_mtsa : _zz_n2_o_mtsa_1);
  assign n2_MTSA = n2_o_mtsa;
  assign io_o_mtsa = n3_n2_MTSA;
  always @(posedge clk) begin
    n2_n1_MTSA <= n1_MTSA;
    n2_n1_SIGN <= n1_SIGN;
    n3_n2_MTSA <= n2_MTSA;
  end


endmodule

//nrshUnit_2 replaced by nrshUnit

//nrshUnit_1 replaced by nrshUnit

//expnAddUnit_33 replaced by expnAddUnit

//expnAddUnit_32 replaced by expnAddUnit

//expnAddUnit_31 replaced by expnAddUnit

//expnAddUnit_30 replaced by expnAddUnit

//expnAddUnit_29 replaced by expnAddUnit

//expnAddUnit_28 replaced by expnAddUnit

//expnAddUnit_27 replaced by expnAddUnit

//expnAddUnit_26 replaced by expnAddUnit

//expnAddUnit_25 replaced by expnAddUnit

//expnAddUnit_24 replaced by expnAddUnit

//expnAddUnit_23 replaced by expnAddUnit

//expnAddUnit_22 replaced by expnAddUnit

//expnAddUnit_21 replaced by expnAddUnit

//expnAddUnit_20 replaced by expnAddUnit

//expnAddUnit_19 replaced by expnAddUnit

//expnAddUnit_18 replaced by expnAddUnit

//expnAddUnit_17 replaced by expnAddUnit

//expnAddUnit_16 replaced by expnAddUnit

//expnAddUnit_15 replaced by expnAddUnit

//expnAddUnit_14 replaced by expnAddUnit

//expnAddUnit_13 replaced by expnAddUnit

//expnAddUnit_12 replaced by expnAddUnit

//expnAddUnit_11 replaced by expnAddUnit

//expnAddUnit_10 replaced by expnAddUnit

//expnAddUnit_9 replaced by expnAddUnit

//expnAddUnit_8 replaced by expnAddUnit

//expnAddUnit_7 replaced by expnAddUnit

//expnAddUnit_6 replaced by expnAddUnit

//expnAddUnit_5 replaced by expnAddUnit

//expnAddUnit_4 replaced by expnAddUnit

//expnAddUnit_3 replaced by expnAddUnit

//expnAddUnit_2 replaced by expnAddUnit

//mulUnit_16 replaced by mulUnit

//mulUnit_15 replaced by mulUnit

//mulUnit_14 replaced by mulUnit

//mulUnit_13 replaced by mulUnit

//mulUnit_12 replaced by mulUnit

//mulUnit_11 replaced by mulUnit

//mulUnit_10 replaced by mulUnit

//mulUnit_9 replaced by mulUnit

//mulUnit_8 replaced by mulUnit

//mulUnit_7 replaced by mulUnit

//mulUnit_6 replaced by mulUnit

//mulUnit_5 replaced by mulUnit

//mulUnit_4 replaced by mulUnit

//mulUnit_3 replaced by mulUnit

//mulUnit_2 replaced by mulUnit

//mulUnit_1 replaced by mulUnit

module vecCPath (
  input  wire [2:0]    io_op,
  input  wire [31:0]   io_vecC_0,
  input  wire [31:0]   io_vecC_1,
  output wire [23:0]   io_c_mtsa_0,
  output wire [23:0]   io_c_mtsa_1,
  output wire [9:0]    io_c_expn_0,
  output wire [9:0]    io_c_expn_1,
  output wire          io_c_sign_0,
  output wire          io_c_sign_1,
  output wire [1:0]    io_c_flag_0,
  output wire [1:0]    io_c_flag_1,
  input  wire          clk,
  input  wire          resetn
);
  localparam ArithOp_FP32 = 3'd1;
  localparam ArithOp_FP16 = 3'd2;
  localparam ArithOp_FP16_MIX = 3'd3;
  localparam ArithOp_INT8 = 3'd4;
  localparam ArithOp_INT4 = 3'd5;
  localparam FpFlag_ZERO = 2'd0;
  localparam FpFlag_NORM = 2'd1;
  localparam FpFlag_INF = 2'd2;
  localparam FpFlag_NAN = 2'd3;
  localparam PackOp_INTx = 2'd0;
  localparam PackOp_FP32 = 2'd1;
  localparam PackOp_FP16 = 2'd2;

  wire       [9:0]    expnAddUnit_34_io_P_expn;
  wire                expnAddUnit_34_io_P_sign;
  wire       [1:0]    expnAddUnit_34_io_P_flag;
  wire       [31:0]   unpacker_0_io_mtsa;
  wire       [7:0]    unpacker_0_io_expn_0;
  wire       [7:0]    unpacker_0_io_expn_1;
  wire                unpacker_0_io_sign_0;
  wire                unpacker_0_io_sign_1;
  wire       [1:0]    unpacker_0_io_flag_0;
  wire       [1:0]    unpacker_0_io_flag_1;
  wire       [31:0]   unpacker_1_io_mtsa;
  wire       [7:0]    unpacker_1_io_expn_0;
  wire       [7:0]    unpacker_1_io_expn_1;
  wire                unpacker_1_io_sign_0;
  wire                unpacker_1_io_sign_1;
  wire       [1:0]    unpacker_1_io_flag_0;
  wire       [1:0]    unpacker_1_io_flag_1;
  reg        [1:0]    CDpackMode;
  wire       [23:0]   C0_mtsa_f32;
  wire       [11:0]   C1_mtsa_f16;
  wire       [23:0]   C1_mtsa_f32;
  wire       [23:0]   C1_mtsa;
  wire       [7:0]    C1_expn;
  wire                C1_sign;
  wire       [1:0]    C1_flag;
  reg        [23:0]   C0_mtsa_f32_regNext;
  reg        [9:0]    _zz_io_c_expn_0;
  reg                 unpacker_0_io_sign_0_regNext;
  reg        [1:0]    unpacker_0_io_flag_0_regNext;
  reg        [23:0]   C1_mtsa_regNext;
  reg        [9:0]    _zz_io_c_expn_1;
  reg                 C1_sign_regNext;
  reg        [1:0]    C1_flag_regNext;
  `ifndef SYNTHESIS
  reg [63:0] io_op_string;
  reg [31:0] io_c_flag_0_string;
  reg [31:0] io_c_flag_1_string;
  reg [31:0] CDpackMode_string;
  reg [31:0] C1_flag_string;
  reg [31:0] unpacker_0_io_flag_0_regNext_string;
  reg [31:0] C1_flag_regNext_string;
  `endif


  expnAddUnit expnAddUnit_34 (
    .io_op     (                             ), //i
    .io_A_expn (                             ), //i
    .io_A_sign (                             ), //i
    .io_A_flag (                             ), //i
    .io_B_expn (                             ), //i
    .io_B_sign (                             ), //i
    .io_B_flag (                             ), //i
    .io_P_expn (expnAddUnit_34_io_P_expn[9:0]), //o
    .io_P_sign (expnAddUnit_34_io_P_sign     ), //o
    .io_P_flag (expnAddUnit_34_io_P_flag[1:0]), //o
    .clk       (clk                          ), //i
    .resetn    (resetn                       )  //i
  );
  unPackUnit unpacker_0 (
    .io_op     (CDpackMode[1:0]          ), //i
    .io_xf     (io_vecC_0[31:0]          ), //i
    .io_mtsa   (unpacker_0_io_mtsa[31:0] ), //o
    .io_expn_0 (unpacker_0_io_expn_0[7:0]), //o
    .io_expn_1 (unpacker_0_io_expn_1[7:0]), //o
    .io_sign_0 (unpacker_0_io_sign_0     ), //o
    .io_sign_1 (unpacker_0_io_sign_1     ), //o
    .io_flag_0 (unpacker_0_io_flag_0[1:0]), //o
    .io_flag_1 (unpacker_0_io_flag_1[1:0]), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  unPackUnit unpacker_1 (
    .io_op     (CDpackMode[1:0]          ), //i
    .io_xf     (io_vecC_1[31:0]          ), //i
    .io_mtsa   (unpacker_1_io_mtsa[31:0] ), //o
    .io_expn_0 (unpacker_1_io_expn_0[7:0]), //o
    .io_expn_1 (unpacker_1_io_expn_1[7:0]), //o
    .io_sign_0 (unpacker_1_io_sign_0     ), //o
    .io_sign_1 (unpacker_1_io_sign_1     ), //o
    .io_flag_0 (unpacker_1_io_flag_0[1:0]), //o
    .io_flag_1 (unpacker_1_io_flag_1[1:0]), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      ArithOp_FP32 : io_op_string = "FP32    ";
      ArithOp_FP16 : io_op_string = "FP16    ";
      ArithOp_FP16_MIX : io_op_string = "FP16_MIX";
      ArithOp_INT8 : io_op_string = "INT8    ";
      ArithOp_INT4 : io_op_string = "INT4    ";
      default : io_op_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_c_flag_0)
      FpFlag_ZERO : io_c_flag_0_string = "ZERO";
      FpFlag_NORM : io_c_flag_0_string = "NORM";
      FpFlag_INF : io_c_flag_0_string = "INF ";
      FpFlag_NAN : io_c_flag_0_string = "NAN ";
      default : io_c_flag_0_string = "????";
    endcase
  end
  always @(*) begin
    case(io_c_flag_1)
      FpFlag_ZERO : io_c_flag_1_string = "ZERO";
      FpFlag_NORM : io_c_flag_1_string = "NORM";
      FpFlag_INF : io_c_flag_1_string = "INF ";
      FpFlag_NAN : io_c_flag_1_string = "NAN ";
      default : io_c_flag_1_string = "????";
    endcase
  end
  always @(*) begin
    case(CDpackMode)
      PackOp_INTx : CDpackMode_string = "INTx";
      PackOp_FP32 : CDpackMode_string = "FP32";
      PackOp_FP16 : CDpackMode_string = "FP16";
      default : CDpackMode_string = "????";
    endcase
  end
  always @(*) begin
    case(C1_flag)
      FpFlag_ZERO : C1_flag_string = "ZERO";
      FpFlag_NORM : C1_flag_string = "NORM";
      FpFlag_INF : C1_flag_string = "INF ";
      FpFlag_NAN : C1_flag_string = "NAN ";
      default : C1_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(unpacker_0_io_flag_0_regNext)
      FpFlag_ZERO : unpacker_0_io_flag_0_regNext_string = "ZERO";
      FpFlag_NORM : unpacker_0_io_flag_0_regNext_string = "NORM";
      FpFlag_INF : unpacker_0_io_flag_0_regNext_string = "INF ";
      FpFlag_NAN : unpacker_0_io_flag_0_regNext_string = "NAN ";
      default : unpacker_0_io_flag_0_regNext_string = "????";
    endcase
  end
  always @(*) begin
    case(C1_flag_regNext)
      FpFlag_ZERO : C1_flag_regNext_string = "ZERO";
      FpFlag_NORM : C1_flag_regNext_string = "NORM";
      FpFlag_INF : C1_flag_regNext_string = "INF ";
      FpFlag_NAN : C1_flag_regNext_string = "NAN ";
      default : C1_flag_regNext_string = "????";
    endcase
  end
  `endif

  assign C0_mtsa_f32 = unpacker_0_io_mtsa[23 : 0];
  assign C1_mtsa_f16 = unpacker_0_io_mtsa[23 : 12];
  assign C1_mtsa_f32 = unpacker_1_io_mtsa[23 : 0];
  assign C1_mtsa = ((io_op == ArithOp_FP16_MIX) ? C1_mtsa_f32 : {12'h0,C1_mtsa_f16});
  assign C1_expn = ((io_op == ArithOp_FP16_MIX) ? unpacker_1_io_expn_0 : unpacker_0_io_expn_1);
  assign C1_sign = ((io_op == ArithOp_FP16_MIX) ? unpacker_1_io_sign_0 : unpacker_0_io_sign_1);
  assign C1_flag = ((io_op == ArithOp_FP16_MIX) ? unpacker_1_io_flag_0 : unpacker_0_io_flag_1);
  assign io_c_mtsa_0 = C0_mtsa_f32_regNext;
  assign io_c_expn_0 = _zz_io_c_expn_0;
  assign io_c_sign_0 = unpacker_0_io_sign_0_regNext;
  assign io_c_flag_0 = unpacker_0_io_flag_0_regNext;
  assign io_c_mtsa_1 = C1_mtsa_regNext;
  assign io_c_expn_1 = _zz_io_c_expn_1;
  assign io_c_sign_1 = C1_sign_regNext;
  assign io_c_flag_1 = C1_flag_regNext;
  always @(posedge clk) begin
    case(io_op)
      ArithOp_FP32 : begin
        CDpackMode <= PackOp_FP32;
      end
      ArithOp_FP16 : begin
        CDpackMode <= PackOp_FP16;
      end
      ArithOp_FP16_MIX : begin
        CDpackMode <= PackOp_FP32;
      end
      default : begin
        CDpackMode <= PackOp_INTx;
      end
    endcase
    C0_mtsa_f32_regNext <= C0_mtsa_f32;
    _zz_io_c_expn_0 <= {2'b00,unpacker_0_io_expn_0};
    unpacker_0_io_sign_0_regNext <= unpacker_0_io_sign_0;
    unpacker_0_io_flag_0_regNext <= unpacker_0_io_flag_0;
    C1_mtsa_regNext <= C1_mtsa;
    _zz_io_c_expn_1 <= {2'b00,C1_expn};
    C1_sign_regNext <= C1_sign;
    C1_flag_regNext <= C1_flag;
  end


endmodule

//unPackUnit_33 replaced by unPackUnit

//unPackUnit_32 replaced by unPackUnit

//unPackUnit_31 replaced by unPackUnit

//unPackUnit_30 replaced by unPackUnit

//unPackUnit_29 replaced by unPackUnit

//unPackUnit_28 replaced by unPackUnit

//unPackUnit_27 replaced by unPackUnit

//unPackUnit_26 replaced by unPackUnit

//unPackUnit_25 replaced by unPackUnit

//unPackUnit_24 replaced by unPackUnit

//unPackUnit_23 replaced by unPackUnit

//unPackUnit_22 replaced by unPackUnit

//unPackUnit_21 replaced by unPackUnit

//unPackUnit_20 replaced by unPackUnit

//unPackUnit_19 replaced by unPackUnit

//unPackUnit_18 replaced by unPackUnit

//unPackUnit_17 replaced by unPackUnit

//unPackUnit_16 replaced by unPackUnit

//unPackUnit_15 replaced by unPackUnit

//unPackUnit_14 replaced by unPackUnit

//unPackUnit_13 replaced by unPackUnit

//unPackUnit_12 replaced by unPackUnit

//unPackUnit_11 replaced by unPackUnit

//unPackUnit_10 replaced by unPackUnit

//unPackUnit_9 replaced by unPackUnit

//unPackUnit_8 replaced by unPackUnit

//unPackUnit_7 replaced by unPackUnit

//unPackUnit_6 replaced by unPackUnit

//unPackUnit_5 replaced by unPackUnit

//unPackUnit_4 replaced by unPackUnit

//unPackUnit_3 replaced by unPackUnit

//unPackUnit_2 replaced by unPackUnit

module nrshUnit (
  input  wire [9:0]    io_P_expn_0,
  input  wire [9:0]    io_P_expn_1,
  input  wire [9:0]    io_P_expn_2,
  input  wire [9:0]    io_P_expn_3,
  input  wire [9:0]    io_P_expn_4,
  input  wire [9:0]    io_P_expn_5,
  input  wire [9:0]    io_P_expn_6,
  input  wire [9:0]    io_P_expn_7,
  input  wire [9:0]    io_P_expn_8,
  input  wire [9:0]    io_P_expn_9,
  input  wire [9:0]    io_P_expn_10,
  input  wire [9:0]    io_P_expn_11,
  input  wire [9:0]    io_P_expn_12,
  input  wire [9:0]    io_P_expn_13,
  input  wire [9:0]    io_P_expn_14,
  input  wire [9:0]    io_P_expn_15,
  input  wire [9:0]    io_P_expn_16,
  input  wire          io_P_sign_0,
  input  wire          io_P_sign_1,
  input  wire          io_P_sign_2,
  input  wire          io_P_sign_3,
  input  wire          io_P_sign_4,
  input  wire          io_P_sign_5,
  input  wire          io_P_sign_6,
  input  wire          io_P_sign_7,
  input  wire          io_P_sign_8,
  input  wire          io_P_sign_9,
  input  wire          io_P_sign_10,
  input  wire          io_P_sign_11,
  input  wire          io_P_sign_12,
  input  wire          io_P_sign_13,
  input  wire          io_P_sign_14,
  input  wire          io_P_sign_15,
  input  wire          io_P_sign_16,
  input  wire [1:0]    io_P_flag_0,
  input  wire [1:0]    io_P_flag_1,
  input  wire [1:0]    io_P_flag_2,
  input  wire [1:0]    io_P_flag_3,
  input  wire [1:0]    io_P_flag_4,
  input  wire [1:0]    io_P_flag_5,
  input  wire [1:0]    io_P_flag_6,
  input  wire [1:0]    io_P_flag_7,
  input  wire [1:0]    io_P_flag_8,
  input  wire [1:0]    io_P_flag_9,
  input  wire [1:0]    io_P_flag_10,
  input  wire [1:0]    io_P_flag_11,
  input  wire [1:0]    io_P_flag_12,
  input  wire [1:0]    io_P_flag_13,
  input  wire [1:0]    io_P_flag_14,
  input  wire [1:0]    io_P_flag_15,
  input  wire [1:0]    io_P_flag_16,
  output wire [9:0]    io_P_nrsh_0,
  output wire [9:0]    io_P_nrsh_1,
  output wire [9:0]    io_P_nrsh_2,
  output wire [9:0]    io_P_nrsh_3,
  output wire [9:0]    io_P_nrsh_4,
  output wire [9:0]    io_P_nrsh_5,
  output wire [9:0]    io_P_nrsh_6,
  output wire [9:0]    io_P_nrsh_7,
  output wire [9:0]    io_P_nrsh_8,
  output wire [9:0]    io_P_nrsh_9,
  output wire [9:0]    io_P_nrsh_10,
  output wire [9:0]    io_P_nrsh_11,
  output wire [9:0]    io_P_nrsh_12,
  output wire [9:0]    io_P_nrsh_13,
  output wire [9:0]    io_P_nrsh_14,
  output wire [9:0]    io_P_nrsh_15,
  output wire [9:0]    io_P_nrsh_16,
  output wire [9:0]    io_Q_expn,
  output wire          io_Q_sign,
  output wire [1:0]    io_Q_flag,
  input  wire          clk,
  input  wire          resetn
);
  localparam FpFlag_ZERO = 2'd0;
  localparam FpFlag_NORM = 2'd1;
  localparam FpFlag_INF = 2'd2;
  localparam FpFlag_NAN = 2'd3;

  wire       [0:0]    _zz_n1_P_SIGN;
  wire       [5:0]    _zz_n1_P_SIGN_1;
  wire       [1:0]    _zz_n2_isNaN;
  wire                _zz_n2_isNaN_1;
  wire       [0:0]    _zz_n2_isNaN_2;
  wire       [8:0]    _zz_n2_isNaN_3;
  wire       [1:0]    _zz_n2_isNaN_4;
  wire                _zz_n2_isNaN_5;
  wire       [0:0]    _zz_n2_isNaN_6;
  wire       [1:0]    _zz_n2_isNaN_7;
  wire       [1:0]    _zz_n2_isInf;
  wire                _zz_n2_isInf_1;
  wire       [0:0]    _zz_n2_isInf_2;
  wire       [8:0]    _zz_n2_isInf_3;
  wire       [1:0]    _zz_n2_isInf_4;
  wire                _zz_n2_isInf_5;
  wire       [0:0]    _zz_n2_isInf_6;
  wire       [1:0]    _zz_n2_isInf_7;
  wire       [9:0]    _zz_n3_rsh_0;
  wire       [9:0]    _zz_n3_rsh_1;
  wire       [9:0]    _zz_n3_rsh_2;
  wire       [9:0]    _zz_n3_rsh_3;
  wire       [9:0]    _zz_n3_rsh_4;
  wire       [9:0]    _zz_n3_rsh_5;
  wire       [9:0]    _zz_n3_rsh_6;
  wire       [9:0]    _zz_n3_rsh_7;
  wire       [9:0]    _zz_n3_rsh_8;
  wire       [9:0]    _zz_n3_rsh_9;
  wire       [9:0]    _zz_n3_rsh_10;
  wire       [9:0]    _zz_n3_rsh_11;
  wire       [9:0]    _zz_n3_rsh_12;
  wire       [9:0]    _zz_n3_rsh_13;
  wire       [9:0]    _zz_n3_rsh_14;
  wire       [9:0]    _zz_n3_rsh_15;
  wire       [9:0]    _zz_n3_rsh_16;
  reg        [1:0]    n3_n2_Q_FLAG;
  reg                 n3_n2_Q_SIGN;
  reg        [9:0]    n2_n1_P_EXPN_0;
  reg        [9:0]    n2_n1_P_EXPN_1;
  reg        [9:0]    n2_n1_P_EXPN_2;
  reg        [9:0]    n2_n1_P_EXPN_3;
  reg        [9:0]    n2_n1_P_EXPN_4;
  reg        [9:0]    n2_n1_P_EXPN_5;
  reg        [9:0]    n2_n1_P_EXPN_6;
  reg        [9:0]    n2_n1_P_EXPN_7;
  reg        [9:0]    n2_n1_P_EXPN_8;
  reg        [9:0]    n2_n1_P_EXPN_9;
  reg        [9:0]    n2_n1_P_EXPN_10;
  reg        [9:0]    n2_n1_P_EXPN_11;
  reg        [9:0]    n2_n1_P_EXPN_12;
  reg        [9:0]    n2_n1_P_EXPN_13;
  reg        [9:0]    n2_n1_P_EXPN_14;
  reg        [9:0]    n2_n1_P_EXPN_15;
  reg        [9:0]    n2_n1_P_EXPN_16;
  reg        [1:0]    n4_n2_Q_FLAG;
  reg                 n4_n2_Q_SIGN;
  reg        [9:0]    n4_n2_Q_EXPN;
  reg        [9:0]    n4_n3_P_NRSH_0;
  reg        [9:0]    n4_n3_P_NRSH_1;
  reg        [9:0]    n4_n3_P_NRSH_2;
  reg        [9:0]    n4_n3_P_NRSH_3;
  reg        [9:0]    n4_n3_P_NRSH_4;
  reg        [9:0]    n4_n3_P_NRSH_5;
  reg        [9:0]    n4_n3_P_NRSH_6;
  reg        [9:0]    n4_n3_P_NRSH_7;
  reg        [9:0]    n4_n3_P_NRSH_8;
  reg        [9:0]    n4_n3_P_NRSH_9;
  reg        [9:0]    n4_n3_P_NRSH_10;
  reg        [9:0]    n4_n3_P_NRSH_11;
  reg        [9:0]    n4_n3_P_NRSH_12;
  reg        [9:0]    n4_n3_P_NRSH_13;
  reg        [9:0]    n4_n3_P_NRSH_14;
  reg        [9:0]    n4_n3_P_NRSH_15;
  reg        [9:0]    n4_n3_P_NRSH_16;
  wire       [9:0]    n3_P_NRSH_0;
  wire       [9:0]    n3_P_NRSH_1;
  wire       [9:0]    n3_P_NRSH_2;
  wire       [9:0]    n3_P_NRSH_3;
  wire       [9:0]    n3_P_NRSH_4;
  wire       [9:0]    n3_P_NRSH_5;
  wire       [9:0]    n3_P_NRSH_6;
  wire       [9:0]    n3_P_NRSH_7;
  wire       [9:0]    n3_P_NRSH_8;
  wire       [9:0]    n3_P_NRSH_9;
  wire       [9:0]    n3_P_NRSH_10;
  wire       [9:0]    n3_P_NRSH_11;
  wire       [9:0]    n3_P_NRSH_12;
  wire       [9:0]    n3_P_NRSH_13;
  wire       [9:0]    n3_P_NRSH_14;
  wire       [9:0]    n3_P_NRSH_15;
  wire       [9:0]    n3_P_NRSH_16;
  reg        [9:0]    n3_n1_P_EXPN_0;
  reg        [9:0]    n3_n1_P_EXPN_1;
  reg        [9:0]    n3_n1_P_EXPN_2;
  reg        [9:0]    n3_n1_P_EXPN_3;
  reg        [9:0]    n3_n1_P_EXPN_4;
  reg        [9:0]    n3_n1_P_EXPN_5;
  reg        [9:0]    n3_n1_P_EXPN_6;
  reg        [9:0]    n3_n1_P_EXPN_7;
  reg        [9:0]    n3_n1_P_EXPN_8;
  reg        [9:0]    n3_n1_P_EXPN_9;
  reg        [9:0]    n3_n1_P_EXPN_10;
  reg        [9:0]    n3_n1_P_EXPN_11;
  reg        [9:0]    n3_n1_P_EXPN_12;
  reg        [9:0]    n3_n1_P_EXPN_13;
  reg        [9:0]    n3_n1_P_EXPN_14;
  reg        [9:0]    n3_n1_P_EXPN_15;
  reg        [9:0]    n3_n1_P_EXPN_16;
  reg        [9:0]    n3_n2_Q_EXPN;
  wire       [1:0]    n2_Q_FLAG;
  wire                n2_Q_SIGN;
  wire       [9:0]    n2_Q_EXPN;
  reg        [9:0]    n2_n1_M_EXPN_0;
  reg        [9:0]    n2_n1_M_EXPN_1;
  reg        [9:0]    n2_n1_M_EXPN_2;
  reg        [9:0]    n2_n1_M_EXPN_3;
  reg        [16:0]   n2_n1_P_SIGN;
  reg        [1:0]    n2_n1_P_FLAG_0;
  reg        [1:0]    n2_n1_P_FLAG_1;
  reg        [1:0]    n2_n1_P_FLAG_2;
  reg        [1:0]    n2_n1_P_FLAG_3;
  reg        [1:0]    n2_n1_P_FLAG_4;
  reg        [1:0]    n2_n1_P_FLAG_5;
  reg        [1:0]    n2_n1_P_FLAG_6;
  reg        [1:0]    n2_n1_P_FLAG_7;
  reg        [1:0]    n2_n1_P_FLAG_8;
  reg        [1:0]    n2_n1_P_FLAG_9;
  reg        [1:0]    n2_n1_P_FLAG_10;
  reg        [1:0]    n2_n1_P_FLAG_11;
  reg        [1:0]    n2_n1_P_FLAG_12;
  reg        [1:0]    n2_n1_P_FLAG_13;
  reg        [1:0]    n2_n1_P_FLAG_14;
  reg        [1:0]    n2_n1_P_FLAG_15;
  reg        [1:0]    n2_n1_P_FLAG_16;
  wire       [1:0]    n1_P_FLAG_0;
  wire       [1:0]    n1_P_FLAG_1;
  wire       [1:0]    n1_P_FLAG_2;
  wire       [1:0]    n1_P_FLAG_3;
  wire       [1:0]    n1_P_FLAG_4;
  wire       [1:0]    n1_P_FLAG_5;
  wire       [1:0]    n1_P_FLAG_6;
  wire       [1:0]    n1_P_FLAG_7;
  wire       [1:0]    n1_P_FLAG_8;
  wire       [1:0]    n1_P_FLAG_9;
  wire       [1:0]    n1_P_FLAG_10;
  wire       [1:0]    n1_P_FLAG_11;
  wire       [1:0]    n1_P_FLAG_12;
  wire       [1:0]    n1_P_FLAG_13;
  wire       [1:0]    n1_P_FLAG_14;
  wire       [1:0]    n1_P_FLAG_15;
  wire       [1:0]    n1_P_FLAG_16;
  wire       [16:0]   n1_P_SIGN;
  wire       [9:0]    n1_P_EXPN_0;
  wire       [9:0]    n1_P_EXPN_1;
  wire       [9:0]    n1_P_EXPN_2;
  wire       [9:0]    n1_P_EXPN_3;
  wire       [9:0]    n1_P_EXPN_4;
  wire       [9:0]    n1_P_EXPN_5;
  wire       [9:0]    n1_P_EXPN_6;
  wire       [9:0]    n1_P_EXPN_7;
  wire       [9:0]    n1_P_EXPN_8;
  wire       [9:0]    n1_P_EXPN_9;
  wire       [9:0]    n1_P_EXPN_10;
  wire       [9:0]    n1_P_EXPN_11;
  wire       [9:0]    n1_P_EXPN_12;
  wire       [9:0]    n1_P_EXPN_13;
  wire       [9:0]    n1_P_EXPN_14;
  wire       [9:0]    n1_P_EXPN_15;
  wire       [9:0]    n1_P_EXPN_16;
  wire       [9:0]    n1_M_EXPN_0;
  wire       [9:0]    n1_M_EXPN_1;
  wire       [9:0]    n1_M_EXPN_2;
  wire       [9:0]    n1_M_EXPN_3;
  wire       [9:0]    n1_expn_0;
  wire       [9:0]    n1_expn_1;
  wire       [9:0]    n1_expn_2;
  wire       [9:0]    n1_expn_3;
  wire       [9:0]    n1_expn_4;
  wire       [9:0]    n1_expn_5;
  wire       [9:0]    n1_expn_6;
  wire       [9:0]    n1_expn_7;
  wire       [9:0]    n1_expn_8;
  wire       [9:0]    n1_expn_9;
  wire       [9:0]    n1_expn_10;
  wire       [9:0]    n1_expn_11;
  wire       [9:0]    n1_expn_12;
  wire       [9:0]    n1_expn_13;
  wire       [9:0]    n1_expn_14;
  wire       [9:0]    n1_expn_15;
  wire       [9:0]    n1_expn_16;
  wire       [9:0]    n1_maxExpn_0;
  wire       [9:0]    n1_maxExpn_1;
  wire       [9:0]    n1_maxExpn_2;
  wire       [9:0]    n1_maxExpn_3;
  wire       [9:0]    _zz_n1_maxExpn_0;
  wire       [9:0]    _zz_n1_maxExpn_0_1;
  wire       [9:0]    _zz_n1_maxExpn_1;
  wire       [9:0]    _zz_n1_maxExpn_1_1;
  wire       [9:0]    _zz_n1_maxExpn_2;
  wire       [9:0]    _zz_n1_maxExpn_2_1;
  wire       [9:0]    _zz_n1_maxExpn_3;
  wire       [9:0]    _zz_n1_maxExpn_3_1;
  wire       [9:0]    _zz_n1_maxExpn_3_2;
  wire       [16:0]   n2_isNaN;
  wire       [16:0]   n2_isInf;
  wire                n2_existNaN;
  wire                n2_existPosInf;
  wire                n2_existNegInf;
  wire       [9:0]    _zz_n2_maxExpn;
  wire       [9:0]    _zz_n2_maxExpn_1;
  wire       [9:0]    n2_maxExpn;
  reg                 n2_Q_sign_1;
  reg        [1:0]    n2_Q_flag_1;
  wire                when_alignUnit_l99;
  wire                when_alignUnit_l102;
  wire       [9:0]    n3_rsh_0;
  wire       [9:0]    n3_rsh_1;
  wire       [9:0]    n3_rsh_2;
  wire       [9:0]    n3_rsh_3;
  wire       [9:0]    n3_rsh_4;
  wire       [9:0]    n3_rsh_5;
  wire       [9:0]    n3_rsh_6;
  wire       [9:0]    n3_rsh_7;
  wire       [9:0]    n3_rsh_8;
  wire       [9:0]    n3_rsh_9;
  wire       [9:0]    n3_rsh_10;
  wire       [9:0]    n3_rsh_11;
  wire       [9:0]    n3_rsh_12;
  wire       [9:0]    n3_rsh_13;
  wire       [9:0]    n3_rsh_14;
  wire       [9:0]    n3_rsh_15;
  wire       [9:0]    n3_rsh_16;
  `ifndef SYNTHESIS
  reg [31:0] n3_n2_Q_FLAG_string;
  reg [31:0] n4_n2_Q_FLAG_string;
  reg [31:0] n2_Q_FLAG_string;
  reg [31:0] n2_n1_P_FLAG_0_string;
  reg [31:0] n2_n1_P_FLAG_1_string;
  reg [31:0] n2_n1_P_FLAG_2_string;
  reg [31:0] n2_n1_P_FLAG_3_string;
  reg [31:0] n2_n1_P_FLAG_4_string;
  reg [31:0] n2_n1_P_FLAG_5_string;
  reg [31:0] n2_n1_P_FLAG_6_string;
  reg [31:0] n2_n1_P_FLAG_7_string;
  reg [31:0] n2_n1_P_FLAG_8_string;
  reg [31:0] n2_n1_P_FLAG_9_string;
  reg [31:0] n2_n1_P_FLAG_10_string;
  reg [31:0] n2_n1_P_FLAG_11_string;
  reg [31:0] n2_n1_P_FLAG_12_string;
  reg [31:0] n2_n1_P_FLAG_13_string;
  reg [31:0] n2_n1_P_FLAG_14_string;
  reg [31:0] n2_n1_P_FLAG_15_string;
  reg [31:0] n2_n1_P_FLAG_16_string;
  reg [31:0] n1_P_FLAG_0_string;
  reg [31:0] n1_P_FLAG_1_string;
  reg [31:0] n1_P_FLAG_2_string;
  reg [31:0] n1_P_FLAG_3_string;
  reg [31:0] n1_P_FLAG_4_string;
  reg [31:0] n1_P_FLAG_5_string;
  reg [31:0] n1_P_FLAG_6_string;
  reg [31:0] n1_P_FLAG_7_string;
  reg [31:0] n1_P_FLAG_8_string;
  reg [31:0] n1_P_FLAG_9_string;
  reg [31:0] n1_P_FLAG_10_string;
  reg [31:0] n1_P_FLAG_11_string;
  reg [31:0] n1_P_FLAG_12_string;
  reg [31:0] n1_P_FLAG_13_string;
  reg [31:0] n1_P_FLAG_14_string;
  reg [31:0] n1_P_FLAG_15_string;
  reg [31:0] n1_P_FLAG_16_string;
  reg [31:0] io_P_flag_0_string;
  reg [31:0] io_P_flag_1_string;
  reg [31:0] io_P_flag_2_string;
  reg [31:0] io_P_flag_3_string;
  reg [31:0] io_P_flag_4_string;
  reg [31:0] io_P_flag_5_string;
  reg [31:0] io_P_flag_6_string;
  reg [31:0] io_P_flag_7_string;
  reg [31:0] io_P_flag_8_string;
  reg [31:0] io_P_flag_9_string;
  reg [31:0] io_P_flag_10_string;
  reg [31:0] io_P_flag_11_string;
  reg [31:0] io_P_flag_12_string;
  reg [31:0] io_P_flag_13_string;
  reg [31:0] io_P_flag_14_string;
  reg [31:0] io_P_flag_15_string;
  reg [31:0] io_P_flag_16_string;
  reg [31:0] io_Q_flag_string;
  reg [31:0] n2_Q_flag_1_string;
  `endif


  assign _zz_n3_rsh_0 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_0));
  assign _zz_n3_rsh_1 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_1));
  assign _zz_n3_rsh_2 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_2));
  assign _zz_n3_rsh_3 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_3));
  assign _zz_n3_rsh_4 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_4));
  assign _zz_n3_rsh_5 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_5));
  assign _zz_n3_rsh_6 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_6));
  assign _zz_n3_rsh_7 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_7));
  assign _zz_n3_rsh_8 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_8));
  assign _zz_n3_rsh_9 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_9));
  assign _zz_n3_rsh_10 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_10));
  assign _zz_n3_rsh_11 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_11));
  assign _zz_n3_rsh_12 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_12));
  assign _zz_n3_rsh_13 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_13));
  assign _zz_n3_rsh_14 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_14));
  assign _zz_n3_rsh_15 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_15));
  assign _zz_n3_rsh_16 = ($signed(n3_n2_Q_EXPN) - $signed(n3_n1_P_EXPN_16));
  assign _zz_n1_P_SIGN = io_P_sign_6;
  assign _zz_n1_P_SIGN_1 = {io_P_sign_5,{io_P_sign_4,{io_P_sign_3,{io_P_sign_2,{io_P_sign_1,io_P_sign_0}}}}};
  assign _zz_n2_isNaN = FpFlag_NAN;
  assign _zz_n2_isNaN_1 = (n2_n1_P_FLAG_10 == FpFlag_NAN);
  assign _zz_n2_isNaN_2 = (n2_n1_P_FLAG_9 == FpFlag_NAN);
  assign _zz_n2_isNaN_3 = {(n2_n1_P_FLAG_8 == FpFlag_NAN),{(n2_n1_P_FLAG_7 == FpFlag_NAN),{(n2_n1_P_FLAG_6 == FpFlag_NAN),{(n2_n1_P_FLAG_5 == FpFlag_NAN),{(n2_n1_P_FLAG_4 == _zz_n2_isNaN_4),{_zz_n2_isNaN_5,{_zz_n2_isNaN_6,_zz_n2_isNaN_7}}}}}}};
  assign _zz_n2_isNaN_4 = FpFlag_NAN;
  assign _zz_n2_isNaN_5 = (n2_n1_P_FLAG_3 == FpFlag_NAN);
  assign _zz_n2_isNaN_6 = (n2_n1_P_FLAG_2 == FpFlag_NAN);
  assign _zz_n2_isNaN_7 = {(n2_n1_P_FLAG_1 == FpFlag_NAN),(n2_n1_P_FLAG_0 == FpFlag_NAN)};
  assign _zz_n2_isInf = FpFlag_INF;
  assign _zz_n2_isInf_1 = (n2_n1_P_FLAG_10 == FpFlag_INF);
  assign _zz_n2_isInf_2 = (n2_n1_P_FLAG_9 == FpFlag_INF);
  assign _zz_n2_isInf_3 = {(n2_n1_P_FLAG_8 == FpFlag_INF),{(n2_n1_P_FLAG_7 == FpFlag_INF),{(n2_n1_P_FLAG_6 == FpFlag_INF),{(n2_n1_P_FLAG_5 == FpFlag_INF),{(n2_n1_P_FLAG_4 == _zz_n2_isInf_4),{_zz_n2_isInf_5,{_zz_n2_isInf_6,_zz_n2_isInf_7}}}}}}};
  assign _zz_n2_isInf_4 = FpFlag_INF;
  assign _zz_n2_isInf_5 = (n2_n1_P_FLAG_3 == FpFlag_INF);
  assign _zz_n2_isInf_6 = (n2_n1_P_FLAG_2 == FpFlag_INF);
  assign _zz_n2_isInf_7 = {(n2_n1_P_FLAG_1 == FpFlag_INF),(n2_n1_P_FLAG_0 == FpFlag_INF)};
  `ifndef SYNTHESIS
  always @(*) begin
    case(n3_n2_Q_FLAG)
      FpFlag_ZERO : n3_n2_Q_FLAG_string = "ZERO";
      FpFlag_NORM : n3_n2_Q_FLAG_string = "NORM";
      FpFlag_INF : n3_n2_Q_FLAG_string = "INF ";
      FpFlag_NAN : n3_n2_Q_FLAG_string = "NAN ";
      default : n3_n2_Q_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(n4_n2_Q_FLAG)
      FpFlag_ZERO : n4_n2_Q_FLAG_string = "ZERO";
      FpFlag_NORM : n4_n2_Q_FLAG_string = "NORM";
      FpFlag_INF : n4_n2_Q_FLAG_string = "INF ";
      FpFlag_NAN : n4_n2_Q_FLAG_string = "NAN ";
      default : n4_n2_Q_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_Q_FLAG)
      FpFlag_ZERO : n2_Q_FLAG_string = "ZERO";
      FpFlag_NORM : n2_Q_FLAG_string = "NORM";
      FpFlag_INF : n2_Q_FLAG_string = "INF ";
      FpFlag_NAN : n2_Q_FLAG_string = "NAN ";
      default : n2_Q_FLAG_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_0)
      FpFlag_ZERO : n2_n1_P_FLAG_0_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_0_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_0_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_0_string = "NAN ";
      default : n2_n1_P_FLAG_0_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_1)
      FpFlag_ZERO : n2_n1_P_FLAG_1_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_1_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_1_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_1_string = "NAN ";
      default : n2_n1_P_FLAG_1_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_2)
      FpFlag_ZERO : n2_n1_P_FLAG_2_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_2_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_2_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_2_string = "NAN ";
      default : n2_n1_P_FLAG_2_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_3)
      FpFlag_ZERO : n2_n1_P_FLAG_3_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_3_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_3_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_3_string = "NAN ";
      default : n2_n1_P_FLAG_3_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_4)
      FpFlag_ZERO : n2_n1_P_FLAG_4_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_4_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_4_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_4_string = "NAN ";
      default : n2_n1_P_FLAG_4_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_5)
      FpFlag_ZERO : n2_n1_P_FLAG_5_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_5_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_5_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_5_string = "NAN ";
      default : n2_n1_P_FLAG_5_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_6)
      FpFlag_ZERO : n2_n1_P_FLAG_6_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_6_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_6_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_6_string = "NAN ";
      default : n2_n1_P_FLAG_6_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_7)
      FpFlag_ZERO : n2_n1_P_FLAG_7_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_7_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_7_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_7_string = "NAN ";
      default : n2_n1_P_FLAG_7_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_8)
      FpFlag_ZERO : n2_n1_P_FLAG_8_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_8_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_8_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_8_string = "NAN ";
      default : n2_n1_P_FLAG_8_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_9)
      FpFlag_ZERO : n2_n1_P_FLAG_9_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_9_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_9_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_9_string = "NAN ";
      default : n2_n1_P_FLAG_9_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_10)
      FpFlag_ZERO : n2_n1_P_FLAG_10_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_10_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_10_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_10_string = "NAN ";
      default : n2_n1_P_FLAG_10_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_11)
      FpFlag_ZERO : n2_n1_P_FLAG_11_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_11_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_11_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_11_string = "NAN ";
      default : n2_n1_P_FLAG_11_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_12)
      FpFlag_ZERO : n2_n1_P_FLAG_12_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_12_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_12_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_12_string = "NAN ";
      default : n2_n1_P_FLAG_12_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_13)
      FpFlag_ZERO : n2_n1_P_FLAG_13_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_13_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_13_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_13_string = "NAN ";
      default : n2_n1_P_FLAG_13_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_14)
      FpFlag_ZERO : n2_n1_P_FLAG_14_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_14_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_14_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_14_string = "NAN ";
      default : n2_n1_P_FLAG_14_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_15)
      FpFlag_ZERO : n2_n1_P_FLAG_15_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_15_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_15_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_15_string = "NAN ";
      default : n2_n1_P_FLAG_15_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_P_FLAG_16)
      FpFlag_ZERO : n2_n1_P_FLAG_16_string = "ZERO";
      FpFlag_NORM : n2_n1_P_FLAG_16_string = "NORM";
      FpFlag_INF : n2_n1_P_FLAG_16_string = "INF ";
      FpFlag_NAN : n2_n1_P_FLAG_16_string = "NAN ";
      default : n2_n1_P_FLAG_16_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_0)
      FpFlag_ZERO : n1_P_FLAG_0_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_0_string = "NORM";
      FpFlag_INF : n1_P_FLAG_0_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_0_string = "NAN ";
      default : n1_P_FLAG_0_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_1)
      FpFlag_ZERO : n1_P_FLAG_1_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_1_string = "NORM";
      FpFlag_INF : n1_P_FLAG_1_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_1_string = "NAN ";
      default : n1_P_FLAG_1_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_2)
      FpFlag_ZERO : n1_P_FLAG_2_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_2_string = "NORM";
      FpFlag_INF : n1_P_FLAG_2_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_2_string = "NAN ";
      default : n1_P_FLAG_2_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_3)
      FpFlag_ZERO : n1_P_FLAG_3_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_3_string = "NORM";
      FpFlag_INF : n1_P_FLAG_3_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_3_string = "NAN ";
      default : n1_P_FLAG_3_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_4)
      FpFlag_ZERO : n1_P_FLAG_4_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_4_string = "NORM";
      FpFlag_INF : n1_P_FLAG_4_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_4_string = "NAN ";
      default : n1_P_FLAG_4_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_5)
      FpFlag_ZERO : n1_P_FLAG_5_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_5_string = "NORM";
      FpFlag_INF : n1_P_FLAG_5_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_5_string = "NAN ";
      default : n1_P_FLAG_5_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_6)
      FpFlag_ZERO : n1_P_FLAG_6_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_6_string = "NORM";
      FpFlag_INF : n1_P_FLAG_6_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_6_string = "NAN ";
      default : n1_P_FLAG_6_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_7)
      FpFlag_ZERO : n1_P_FLAG_7_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_7_string = "NORM";
      FpFlag_INF : n1_P_FLAG_7_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_7_string = "NAN ";
      default : n1_P_FLAG_7_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_8)
      FpFlag_ZERO : n1_P_FLAG_8_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_8_string = "NORM";
      FpFlag_INF : n1_P_FLAG_8_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_8_string = "NAN ";
      default : n1_P_FLAG_8_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_9)
      FpFlag_ZERO : n1_P_FLAG_9_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_9_string = "NORM";
      FpFlag_INF : n1_P_FLAG_9_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_9_string = "NAN ";
      default : n1_P_FLAG_9_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_10)
      FpFlag_ZERO : n1_P_FLAG_10_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_10_string = "NORM";
      FpFlag_INF : n1_P_FLAG_10_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_10_string = "NAN ";
      default : n1_P_FLAG_10_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_11)
      FpFlag_ZERO : n1_P_FLAG_11_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_11_string = "NORM";
      FpFlag_INF : n1_P_FLAG_11_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_11_string = "NAN ";
      default : n1_P_FLAG_11_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_12)
      FpFlag_ZERO : n1_P_FLAG_12_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_12_string = "NORM";
      FpFlag_INF : n1_P_FLAG_12_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_12_string = "NAN ";
      default : n1_P_FLAG_12_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_13)
      FpFlag_ZERO : n1_P_FLAG_13_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_13_string = "NORM";
      FpFlag_INF : n1_P_FLAG_13_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_13_string = "NAN ";
      default : n1_P_FLAG_13_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_14)
      FpFlag_ZERO : n1_P_FLAG_14_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_14_string = "NORM";
      FpFlag_INF : n1_P_FLAG_14_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_14_string = "NAN ";
      default : n1_P_FLAG_14_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_15)
      FpFlag_ZERO : n1_P_FLAG_15_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_15_string = "NORM";
      FpFlag_INF : n1_P_FLAG_15_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_15_string = "NAN ";
      default : n1_P_FLAG_15_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_P_FLAG_16)
      FpFlag_ZERO : n1_P_FLAG_16_string = "ZERO";
      FpFlag_NORM : n1_P_FLAG_16_string = "NORM";
      FpFlag_INF : n1_P_FLAG_16_string = "INF ";
      FpFlag_NAN : n1_P_FLAG_16_string = "NAN ";
      default : n1_P_FLAG_16_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_0)
      FpFlag_ZERO : io_P_flag_0_string = "ZERO";
      FpFlag_NORM : io_P_flag_0_string = "NORM";
      FpFlag_INF : io_P_flag_0_string = "INF ";
      FpFlag_NAN : io_P_flag_0_string = "NAN ";
      default : io_P_flag_0_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_1)
      FpFlag_ZERO : io_P_flag_1_string = "ZERO";
      FpFlag_NORM : io_P_flag_1_string = "NORM";
      FpFlag_INF : io_P_flag_1_string = "INF ";
      FpFlag_NAN : io_P_flag_1_string = "NAN ";
      default : io_P_flag_1_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_2)
      FpFlag_ZERO : io_P_flag_2_string = "ZERO";
      FpFlag_NORM : io_P_flag_2_string = "NORM";
      FpFlag_INF : io_P_flag_2_string = "INF ";
      FpFlag_NAN : io_P_flag_2_string = "NAN ";
      default : io_P_flag_2_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_3)
      FpFlag_ZERO : io_P_flag_3_string = "ZERO";
      FpFlag_NORM : io_P_flag_3_string = "NORM";
      FpFlag_INF : io_P_flag_3_string = "INF ";
      FpFlag_NAN : io_P_flag_3_string = "NAN ";
      default : io_P_flag_3_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_4)
      FpFlag_ZERO : io_P_flag_4_string = "ZERO";
      FpFlag_NORM : io_P_flag_4_string = "NORM";
      FpFlag_INF : io_P_flag_4_string = "INF ";
      FpFlag_NAN : io_P_flag_4_string = "NAN ";
      default : io_P_flag_4_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_5)
      FpFlag_ZERO : io_P_flag_5_string = "ZERO";
      FpFlag_NORM : io_P_flag_5_string = "NORM";
      FpFlag_INF : io_P_flag_5_string = "INF ";
      FpFlag_NAN : io_P_flag_5_string = "NAN ";
      default : io_P_flag_5_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_6)
      FpFlag_ZERO : io_P_flag_6_string = "ZERO";
      FpFlag_NORM : io_P_flag_6_string = "NORM";
      FpFlag_INF : io_P_flag_6_string = "INF ";
      FpFlag_NAN : io_P_flag_6_string = "NAN ";
      default : io_P_flag_6_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_7)
      FpFlag_ZERO : io_P_flag_7_string = "ZERO";
      FpFlag_NORM : io_P_flag_7_string = "NORM";
      FpFlag_INF : io_P_flag_7_string = "INF ";
      FpFlag_NAN : io_P_flag_7_string = "NAN ";
      default : io_P_flag_7_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_8)
      FpFlag_ZERO : io_P_flag_8_string = "ZERO";
      FpFlag_NORM : io_P_flag_8_string = "NORM";
      FpFlag_INF : io_P_flag_8_string = "INF ";
      FpFlag_NAN : io_P_flag_8_string = "NAN ";
      default : io_P_flag_8_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_9)
      FpFlag_ZERO : io_P_flag_9_string = "ZERO";
      FpFlag_NORM : io_P_flag_9_string = "NORM";
      FpFlag_INF : io_P_flag_9_string = "INF ";
      FpFlag_NAN : io_P_flag_9_string = "NAN ";
      default : io_P_flag_9_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_10)
      FpFlag_ZERO : io_P_flag_10_string = "ZERO";
      FpFlag_NORM : io_P_flag_10_string = "NORM";
      FpFlag_INF : io_P_flag_10_string = "INF ";
      FpFlag_NAN : io_P_flag_10_string = "NAN ";
      default : io_P_flag_10_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_11)
      FpFlag_ZERO : io_P_flag_11_string = "ZERO";
      FpFlag_NORM : io_P_flag_11_string = "NORM";
      FpFlag_INF : io_P_flag_11_string = "INF ";
      FpFlag_NAN : io_P_flag_11_string = "NAN ";
      default : io_P_flag_11_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_12)
      FpFlag_ZERO : io_P_flag_12_string = "ZERO";
      FpFlag_NORM : io_P_flag_12_string = "NORM";
      FpFlag_INF : io_P_flag_12_string = "INF ";
      FpFlag_NAN : io_P_flag_12_string = "NAN ";
      default : io_P_flag_12_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_13)
      FpFlag_ZERO : io_P_flag_13_string = "ZERO";
      FpFlag_NORM : io_P_flag_13_string = "NORM";
      FpFlag_INF : io_P_flag_13_string = "INF ";
      FpFlag_NAN : io_P_flag_13_string = "NAN ";
      default : io_P_flag_13_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_14)
      FpFlag_ZERO : io_P_flag_14_string = "ZERO";
      FpFlag_NORM : io_P_flag_14_string = "NORM";
      FpFlag_INF : io_P_flag_14_string = "INF ";
      FpFlag_NAN : io_P_flag_14_string = "NAN ";
      default : io_P_flag_14_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_15)
      FpFlag_ZERO : io_P_flag_15_string = "ZERO";
      FpFlag_NORM : io_P_flag_15_string = "NORM";
      FpFlag_INF : io_P_flag_15_string = "INF ";
      FpFlag_NAN : io_P_flag_15_string = "NAN ";
      default : io_P_flag_15_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag_16)
      FpFlag_ZERO : io_P_flag_16_string = "ZERO";
      FpFlag_NORM : io_P_flag_16_string = "NORM";
      FpFlag_INF : io_P_flag_16_string = "INF ";
      FpFlag_NAN : io_P_flag_16_string = "NAN ";
      default : io_P_flag_16_string = "????";
    endcase
  end
  always @(*) begin
    case(io_Q_flag)
      FpFlag_ZERO : io_Q_flag_string = "ZERO";
      FpFlag_NORM : io_Q_flag_string = "NORM";
      FpFlag_INF : io_Q_flag_string = "INF ";
      FpFlag_NAN : io_Q_flag_string = "NAN ";
      default : io_Q_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_Q_flag_1)
      FpFlag_ZERO : n2_Q_flag_1_string = "ZERO";
      FpFlag_NORM : n2_Q_flag_1_string = "NORM";
      FpFlag_INF : n2_Q_flag_1_string = "INF ";
      FpFlag_NAN : n2_Q_flag_1_string = "NAN ";
      default : n2_Q_flag_1_string = "????";
    endcase
  end
  `endif

  assign n1_expn_0 = ((io_P_flag_0 == FpFlag_ZERO) ? 10'h001 : io_P_expn_0);
  assign n1_expn_1 = ((io_P_flag_1 == FpFlag_ZERO) ? 10'h001 : io_P_expn_1);
  assign n1_expn_2 = ((io_P_flag_2 == FpFlag_ZERO) ? 10'h001 : io_P_expn_2);
  assign n1_expn_3 = ((io_P_flag_3 == FpFlag_ZERO) ? 10'h001 : io_P_expn_3);
  assign n1_expn_4 = ((io_P_flag_4 == FpFlag_ZERO) ? 10'h001 : io_P_expn_4);
  assign n1_expn_5 = ((io_P_flag_5 == FpFlag_ZERO) ? 10'h001 : io_P_expn_5);
  assign n1_expn_6 = ((io_P_flag_6 == FpFlag_ZERO) ? 10'h001 : io_P_expn_6);
  assign n1_expn_7 = ((io_P_flag_7 == FpFlag_ZERO) ? 10'h001 : io_P_expn_7);
  assign n1_expn_8 = ((io_P_flag_8 == FpFlag_ZERO) ? 10'h001 : io_P_expn_8);
  assign n1_expn_9 = ((io_P_flag_9 == FpFlag_ZERO) ? 10'h001 : io_P_expn_9);
  assign n1_expn_10 = ((io_P_flag_10 == FpFlag_ZERO) ? 10'h001 : io_P_expn_10);
  assign n1_expn_11 = ((io_P_flag_11 == FpFlag_ZERO) ? 10'h001 : io_P_expn_11);
  assign n1_expn_12 = ((io_P_flag_12 == FpFlag_ZERO) ? 10'h001 : io_P_expn_12);
  assign n1_expn_13 = ((io_P_flag_13 == FpFlag_ZERO) ? 10'h001 : io_P_expn_13);
  assign n1_expn_14 = ((io_P_flag_14 == FpFlag_ZERO) ? 10'h001 : io_P_expn_14);
  assign n1_expn_15 = ((io_P_flag_15 == FpFlag_ZERO) ? 10'h001 : io_P_expn_15);
  assign n1_expn_16 = ((io_P_flag_16 == FpFlag_ZERO) ? 10'h001 : io_P_expn_16);
  assign _zz_n1_maxExpn_0 = (($signed(n1_expn_1) < $signed(n1_expn_0)) ? n1_expn_0 : n1_expn_1);
  assign _zz_n1_maxExpn_0_1 = (($signed(n1_expn_3) < $signed(n1_expn_2)) ? n1_expn_2 : n1_expn_3);
  assign n1_maxExpn_0 = (($signed(_zz_n1_maxExpn_0_1) < $signed(_zz_n1_maxExpn_0)) ? _zz_n1_maxExpn_0 : _zz_n1_maxExpn_0_1);
  assign _zz_n1_maxExpn_1 = (($signed(n1_expn_5) < $signed(n1_expn_4)) ? n1_expn_4 : n1_expn_5);
  assign _zz_n1_maxExpn_1_1 = (($signed(n1_expn_7) < $signed(n1_expn_6)) ? n1_expn_6 : n1_expn_7);
  assign n1_maxExpn_1 = (($signed(_zz_n1_maxExpn_1_1) < $signed(_zz_n1_maxExpn_1)) ? _zz_n1_maxExpn_1 : _zz_n1_maxExpn_1_1);
  assign _zz_n1_maxExpn_2 = (($signed(n1_expn_9) < $signed(n1_expn_8)) ? n1_expn_8 : n1_expn_9);
  assign _zz_n1_maxExpn_2_1 = (($signed(n1_expn_11) < $signed(n1_expn_10)) ? n1_expn_10 : n1_expn_11);
  assign n1_maxExpn_2 = (($signed(_zz_n1_maxExpn_2_1) < $signed(_zz_n1_maxExpn_2)) ? _zz_n1_maxExpn_2 : _zz_n1_maxExpn_2_1);
  assign _zz_n1_maxExpn_3 = (($signed(n1_expn_13) < $signed(n1_expn_12)) ? n1_expn_12 : n1_expn_13);
  assign _zz_n1_maxExpn_3_1 = (($signed(n1_expn_15) < $signed(n1_expn_14)) ? n1_expn_14 : n1_expn_15);
  assign _zz_n1_maxExpn_3_2 = (($signed(_zz_n1_maxExpn_3_1) < $signed(_zz_n1_maxExpn_3)) ? _zz_n1_maxExpn_3 : _zz_n1_maxExpn_3_1);
  assign n1_maxExpn_3 = (($signed(n1_expn_16) < $signed(_zz_n1_maxExpn_3_2)) ? _zz_n1_maxExpn_3_2 : n1_expn_16);
  assign n1_M_EXPN_0 = n1_maxExpn_0;
  assign n1_M_EXPN_1 = n1_maxExpn_1;
  assign n1_M_EXPN_2 = n1_maxExpn_2;
  assign n1_M_EXPN_3 = n1_maxExpn_3;
  assign n1_P_EXPN_0 = n1_expn_0;
  assign n1_P_EXPN_1 = n1_expn_1;
  assign n1_P_EXPN_2 = n1_expn_2;
  assign n1_P_EXPN_3 = n1_expn_3;
  assign n1_P_EXPN_4 = n1_expn_4;
  assign n1_P_EXPN_5 = n1_expn_5;
  assign n1_P_EXPN_6 = n1_expn_6;
  assign n1_P_EXPN_7 = n1_expn_7;
  assign n1_P_EXPN_8 = n1_expn_8;
  assign n1_P_EXPN_9 = n1_expn_9;
  assign n1_P_EXPN_10 = n1_expn_10;
  assign n1_P_EXPN_11 = n1_expn_11;
  assign n1_P_EXPN_12 = n1_expn_12;
  assign n1_P_EXPN_13 = n1_expn_13;
  assign n1_P_EXPN_14 = n1_expn_14;
  assign n1_P_EXPN_15 = n1_expn_15;
  assign n1_P_EXPN_16 = n1_expn_16;
  assign n1_P_SIGN = {io_P_sign_16,{io_P_sign_15,{io_P_sign_14,{io_P_sign_13,{io_P_sign_12,{io_P_sign_11,{io_P_sign_10,{io_P_sign_9,{io_P_sign_8,{io_P_sign_7,{_zz_n1_P_SIGN,_zz_n1_P_SIGN_1}}}}}}}}}}};
  assign n1_P_FLAG_0 = io_P_flag_0;
  assign n1_P_FLAG_1 = io_P_flag_1;
  assign n1_P_FLAG_2 = io_P_flag_2;
  assign n1_P_FLAG_3 = io_P_flag_3;
  assign n1_P_FLAG_4 = io_P_flag_4;
  assign n1_P_FLAG_5 = io_P_flag_5;
  assign n1_P_FLAG_6 = io_P_flag_6;
  assign n1_P_FLAG_7 = io_P_flag_7;
  assign n1_P_FLAG_8 = io_P_flag_8;
  assign n1_P_FLAG_9 = io_P_flag_9;
  assign n1_P_FLAG_10 = io_P_flag_10;
  assign n1_P_FLAG_11 = io_P_flag_11;
  assign n1_P_FLAG_12 = io_P_flag_12;
  assign n1_P_FLAG_13 = io_P_flag_13;
  assign n1_P_FLAG_14 = io_P_flag_14;
  assign n1_P_FLAG_15 = io_P_flag_15;
  assign n1_P_FLAG_16 = io_P_flag_16;
  assign n2_isNaN = {(n2_n1_P_FLAG_16 == FpFlag_NAN),{(n2_n1_P_FLAG_15 == FpFlag_NAN),{(n2_n1_P_FLAG_14 == FpFlag_NAN),{(n2_n1_P_FLAG_13 == FpFlag_NAN),{(n2_n1_P_FLAG_12 == FpFlag_NAN),{(n2_n1_P_FLAG_11 == _zz_n2_isNaN),{_zz_n2_isNaN_1,{_zz_n2_isNaN_2,_zz_n2_isNaN_3}}}}}}}};
  assign n2_isInf = {(n2_n1_P_FLAG_16 == FpFlag_INF),{(n2_n1_P_FLAG_15 == FpFlag_INF),{(n2_n1_P_FLAG_14 == FpFlag_INF),{(n2_n1_P_FLAG_13 == FpFlag_INF),{(n2_n1_P_FLAG_12 == FpFlag_INF),{(n2_n1_P_FLAG_11 == _zz_n2_isInf),{_zz_n2_isInf_1,{_zz_n2_isInf_2,_zz_n2_isInf_3}}}}}}}};
  assign n2_existNaN = (|n2_isNaN);
  assign n2_existPosInf = (|(n2_isInf & (~ n2_n1_P_SIGN)));
  assign n2_existNegInf = (|(n2_isInf & n2_n1_P_SIGN));
  assign _zz_n2_maxExpn = (($signed(n2_n1_M_EXPN_1) < $signed(n2_n1_M_EXPN_0)) ? n2_n1_M_EXPN_0 : n2_n1_M_EXPN_1);
  assign _zz_n2_maxExpn_1 = (($signed(n2_n1_M_EXPN_2) < $signed(_zz_n2_maxExpn)) ? _zz_n2_maxExpn : n2_n1_M_EXPN_2);
  assign n2_maxExpn = (($signed(n2_n1_M_EXPN_3) < $signed(_zz_n2_maxExpn_1)) ? _zz_n2_maxExpn_1 : n2_n1_M_EXPN_3);
  assign when_alignUnit_l99 = (n2_existNaN || (n2_existPosInf && n2_existNegInf));
  always @(*) begin
    if(when_alignUnit_l99) begin
      n2_Q_sign_1 = 1'b0;
    end else begin
      if(when_alignUnit_l102) begin
        n2_Q_sign_1 = n2_existNegInf;
      end else begin
        n2_Q_sign_1 = 1'b0;
      end
    end
  end

  always @(*) begin
    if(when_alignUnit_l99) begin
      n2_Q_flag_1 = FpFlag_NAN;
    end else begin
      if(when_alignUnit_l102) begin
        n2_Q_flag_1 = FpFlag_INF;
      end else begin
        n2_Q_flag_1 = FpFlag_NORM;
      end
    end
  end

  assign when_alignUnit_l102 = (n2_existPosInf || n2_existNegInf);
  assign n2_Q_EXPN = n2_maxExpn;
  assign n2_Q_SIGN = n2_Q_sign_1;
  assign n2_Q_FLAG = n2_Q_flag_1;
  assign n3_rsh_0 = _zz_n3_rsh_0;
  assign n3_rsh_1 = _zz_n3_rsh_1;
  assign n3_rsh_2 = _zz_n3_rsh_2;
  assign n3_rsh_3 = _zz_n3_rsh_3;
  assign n3_rsh_4 = _zz_n3_rsh_4;
  assign n3_rsh_5 = _zz_n3_rsh_5;
  assign n3_rsh_6 = _zz_n3_rsh_6;
  assign n3_rsh_7 = _zz_n3_rsh_7;
  assign n3_rsh_8 = _zz_n3_rsh_8;
  assign n3_rsh_9 = _zz_n3_rsh_9;
  assign n3_rsh_10 = _zz_n3_rsh_10;
  assign n3_rsh_11 = _zz_n3_rsh_11;
  assign n3_rsh_12 = _zz_n3_rsh_12;
  assign n3_rsh_13 = _zz_n3_rsh_13;
  assign n3_rsh_14 = _zz_n3_rsh_14;
  assign n3_rsh_15 = _zz_n3_rsh_15;
  assign n3_rsh_16 = _zz_n3_rsh_16;
  assign n3_P_NRSH_0 = n3_rsh_0;
  assign n3_P_NRSH_1 = n3_rsh_1;
  assign n3_P_NRSH_2 = n3_rsh_2;
  assign n3_P_NRSH_3 = n3_rsh_3;
  assign n3_P_NRSH_4 = n3_rsh_4;
  assign n3_P_NRSH_5 = n3_rsh_5;
  assign n3_P_NRSH_6 = n3_rsh_6;
  assign n3_P_NRSH_7 = n3_rsh_7;
  assign n3_P_NRSH_8 = n3_rsh_8;
  assign n3_P_NRSH_9 = n3_rsh_9;
  assign n3_P_NRSH_10 = n3_rsh_10;
  assign n3_P_NRSH_11 = n3_rsh_11;
  assign n3_P_NRSH_12 = n3_rsh_12;
  assign n3_P_NRSH_13 = n3_rsh_13;
  assign n3_P_NRSH_14 = n3_rsh_14;
  assign n3_P_NRSH_15 = n3_rsh_15;
  assign n3_P_NRSH_16 = n3_rsh_16;
  assign io_P_nrsh_0 = n4_n3_P_NRSH_0;
  assign io_P_nrsh_1 = n4_n3_P_NRSH_1;
  assign io_P_nrsh_2 = n4_n3_P_NRSH_2;
  assign io_P_nrsh_3 = n4_n3_P_NRSH_3;
  assign io_P_nrsh_4 = n4_n3_P_NRSH_4;
  assign io_P_nrsh_5 = n4_n3_P_NRSH_5;
  assign io_P_nrsh_6 = n4_n3_P_NRSH_6;
  assign io_P_nrsh_7 = n4_n3_P_NRSH_7;
  assign io_P_nrsh_8 = n4_n3_P_NRSH_8;
  assign io_P_nrsh_9 = n4_n3_P_NRSH_9;
  assign io_P_nrsh_10 = n4_n3_P_NRSH_10;
  assign io_P_nrsh_11 = n4_n3_P_NRSH_11;
  assign io_P_nrsh_12 = n4_n3_P_NRSH_12;
  assign io_P_nrsh_13 = n4_n3_P_NRSH_13;
  assign io_P_nrsh_14 = n4_n3_P_NRSH_14;
  assign io_P_nrsh_15 = n4_n3_P_NRSH_15;
  assign io_P_nrsh_16 = n4_n3_P_NRSH_16;
  assign io_Q_expn = n4_n2_Q_EXPN;
  assign io_Q_sign = n4_n2_Q_SIGN;
  assign io_Q_flag = n4_n2_Q_FLAG;
  always @(posedge clk) begin
    n2_n1_M_EXPN_0 <= n1_M_EXPN_0;
    n2_n1_M_EXPN_1 <= n1_M_EXPN_1;
    n2_n1_M_EXPN_2 <= n1_M_EXPN_2;
    n2_n1_M_EXPN_3 <= n1_M_EXPN_3;
    n2_n1_P_EXPN_0 <= n1_P_EXPN_0;
    n2_n1_P_EXPN_1 <= n1_P_EXPN_1;
    n2_n1_P_EXPN_2 <= n1_P_EXPN_2;
    n2_n1_P_EXPN_3 <= n1_P_EXPN_3;
    n2_n1_P_EXPN_4 <= n1_P_EXPN_4;
    n2_n1_P_EXPN_5 <= n1_P_EXPN_5;
    n2_n1_P_EXPN_6 <= n1_P_EXPN_6;
    n2_n1_P_EXPN_7 <= n1_P_EXPN_7;
    n2_n1_P_EXPN_8 <= n1_P_EXPN_8;
    n2_n1_P_EXPN_9 <= n1_P_EXPN_9;
    n2_n1_P_EXPN_10 <= n1_P_EXPN_10;
    n2_n1_P_EXPN_11 <= n1_P_EXPN_11;
    n2_n1_P_EXPN_12 <= n1_P_EXPN_12;
    n2_n1_P_EXPN_13 <= n1_P_EXPN_13;
    n2_n1_P_EXPN_14 <= n1_P_EXPN_14;
    n2_n1_P_EXPN_15 <= n1_P_EXPN_15;
    n2_n1_P_EXPN_16 <= n1_P_EXPN_16;
    n2_n1_P_SIGN <= n1_P_SIGN;
    n2_n1_P_FLAG_0 <= n1_P_FLAG_0;
    n2_n1_P_FLAG_1 <= n1_P_FLAG_1;
    n2_n1_P_FLAG_2 <= n1_P_FLAG_2;
    n2_n1_P_FLAG_3 <= n1_P_FLAG_3;
    n2_n1_P_FLAG_4 <= n1_P_FLAG_4;
    n2_n1_P_FLAG_5 <= n1_P_FLAG_5;
    n2_n1_P_FLAG_6 <= n1_P_FLAG_6;
    n2_n1_P_FLAG_7 <= n1_P_FLAG_7;
    n2_n1_P_FLAG_8 <= n1_P_FLAG_8;
    n2_n1_P_FLAG_9 <= n1_P_FLAG_9;
    n2_n1_P_FLAG_10 <= n1_P_FLAG_10;
    n2_n1_P_FLAG_11 <= n1_P_FLAG_11;
    n2_n1_P_FLAG_12 <= n1_P_FLAG_12;
    n2_n1_P_FLAG_13 <= n1_P_FLAG_13;
    n2_n1_P_FLAG_14 <= n1_P_FLAG_14;
    n2_n1_P_FLAG_15 <= n1_P_FLAG_15;
    n2_n1_P_FLAG_16 <= n1_P_FLAG_16;
    n3_n1_P_EXPN_0 <= n2_n1_P_EXPN_0;
    n3_n1_P_EXPN_1 <= n2_n1_P_EXPN_1;
    n3_n1_P_EXPN_2 <= n2_n1_P_EXPN_2;
    n3_n1_P_EXPN_3 <= n2_n1_P_EXPN_3;
    n3_n1_P_EXPN_4 <= n2_n1_P_EXPN_4;
    n3_n1_P_EXPN_5 <= n2_n1_P_EXPN_5;
    n3_n1_P_EXPN_6 <= n2_n1_P_EXPN_6;
    n3_n1_P_EXPN_7 <= n2_n1_P_EXPN_7;
    n3_n1_P_EXPN_8 <= n2_n1_P_EXPN_8;
    n3_n1_P_EXPN_9 <= n2_n1_P_EXPN_9;
    n3_n1_P_EXPN_10 <= n2_n1_P_EXPN_10;
    n3_n1_P_EXPN_11 <= n2_n1_P_EXPN_11;
    n3_n1_P_EXPN_12 <= n2_n1_P_EXPN_12;
    n3_n1_P_EXPN_13 <= n2_n1_P_EXPN_13;
    n3_n1_P_EXPN_14 <= n2_n1_P_EXPN_14;
    n3_n1_P_EXPN_15 <= n2_n1_P_EXPN_15;
    n3_n1_P_EXPN_16 <= n2_n1_P_EXPN_16;
    n3_n2_Q_EXPN <= n2_Q_EXPN;
    n3_n2_Q_SIGN <= n2_Q_SIGN;
    n3_n2_Q_FLAG <= n2_Q_FLAG;
    n4_n2_Q_EXPN <= n3_n2_Q_EXPN;
    n4_n2_Q_SIGN <= n3_n2_Q_SIGN;
    n4_n2_Q_FLAG <= n3_n2_Q_FLAG;
    n4_n3_P_NRSH_0 <= n3_P_NRSH_0;
    n4_n3_P_NRSH_1 <= n3_P_NRSH_1;
    n4_n3_P_NRSH_2 <= n3_P_NRSH_2;
    n4_n3_P_NRSH_3 <= n3_P_NRSH_3;
    n4_n3_P_NRSH_4 <= n3_P_NRSH_4;
    n4_n3_P_NRSH_5 <= n3_P_NRSH_5;
    n4_n3_P_NRSH_6 <= n3_P_NRSH_6;
    n4_n3_P_NRSH_7 <= n3_P_NRSH_7;
    n4_n3_P_NRSH_8 <= n3_P_NRSH_8;
    n4_n3_P_NRSH_9 <= n3_P_NRSH_9;
    n4_n3_P_NRSH_10 <= n3_P_NRSH_10;
    n4_n3_P_NRSH_11 <= n3_P_NRSH_11;
    n4_n3_P_NRSH_12 <= n3_P_NRSH_12;
    n4_n3_P_NRSH_13 <= n3_P_NRSH_13;
    n4_n3_P_NRSH_14 <= n3_P_NRSH_14;
    n4_n3_P_NRSH_15 <= n3_P_NRSH_15;
    n4_n3_P_NRSH_16 <= n3_P_NRSH_16;
  end


endmodule

//expnAddUnit_1 replaced by expnAddUnit

module mulUnit (
  input  wire [2:0]    io_op,
  input  wire [31:0]   io_A_mtsa,
  input  wire [31:0]   io_B_mtsa,
  output wire [63:0]   io_P_mtsa,
  input  wire          clk,
  input  wire          resetn
);
  localparam ArithOp_FP32 = 3'd1;
  localparam ArithOp_FP16 = 3'd2;
  localparam ArithOp_FP16_MIX = 3'd3;
  localparam ArithOp_INT8 = 3'd4;
  localparam ArithOp_INT4 = 3'd5;

  wire                multipler_io_simd;
  wire       [95:0]   multipler_io_P;
  wire       [7:0]    _zz_A_abs_0_1;
  wire       [7:0]    _zz_A_abs_0_2;
  wire       [7:0]    _zz_A_abs_0_3;
  wire       [7:0]    _zz_A_abs_0_4;
  wire       [0:0]    _zz_A_abs_0_5;
  wire       [7:0]    _zz_B_abs_0_1;
  wire       [7:0]    _zz_B_abs_0_2;
  wire       [7:0]    _zz_B_abs_0_3;
  wire       [7:0]    _zz_B_abs_0_4;
  wire       [0:0]    _zz_B_abs_0_5;
  wire       [15:0]   _zz_P_int_0;
  wire       [15:0]   _zz_P_int_0_1;
  wire       [15:0]   _zz_P_int_0_2;
  wire       [7:0]    _zz_A_abs_1_1;
  wire       [7:0]    _zz_A_abs_1_2;
  wire       [7:0]    _zz_A_abs_1_3;
  wire       [7:0]    _zz_A_abs_1_4;
  wire       [0:0]    _zz_A_abs_1_5;
  wire       [7:0]    _zz_B_abs_1_1;
  wire       [7:0]    _zz_B_abs_1_2;
  wire       [7:0]    _zz_B_abs_1_3;
  wire       [7:0]    _zz_B_abs_1_4;
  wire       [0:0]    _zz_B_abs_1_5;
  wire       [15:0]   _zz_P_int_1;
  wire       [15:0]   _zz_P_int_1_1;
  wire       [15:0]   _zz_P_int_1_2;
  wire       [7:0]    _zz_A_abs_2_1;
  wire       [7:0]    _zz_A_abs_2_2;
  wire       [7:0]    _zz_A_abs_2_3;
  wire       [7:0]    _zz_A_abs_2_4;
  wire       [0:0]    _zz_A_abs_2_5;
  wire       [7:0]    _zz_B_abs_2_1;
  wire       [7:0]    _zz_B_abs_2_2;
  wire       [7:0]    _zz_B_abs_2_3;
  wire       [7:0]    _zz_B_abs_2_4;
  wire       [0:0]    _zz_B_abs_2_5;
  wire       [15:0]   _zz_P_int_2;
  wire       [15:0]   _zz_P_int_2_1;
  wire       [15:0]   _zz_P_int_2_2;
  wire       [7:0]    _zz_A_abs_3_1;
  wire       [7:0]    _zz_A_abs_3_2;
  wire       [7:0]    _zz_A_abs_3_3;
  wire       [7:0]    _zz_A_abs_3_4;
  wire       [0:0]    _zz_A_abs_3_5;
  wire       [7:0]    _zz_B_abs_3_1;
  wire       [7:0]    _zz_B_abs_3_2;
  wire       [7:0]    _zz_B_abs_3_3;
  wire       [7:0]    _zz_B_abs_3_4;
  wire       [0:0]    _zz_B_abs_3_5;
  wire       [15:0]   _zz_P_int_3;
  wire       [15:0]   _zz_P_int_3_1;
  wire       [15:0]   _zz_P_int_3_2;
  wire       [7:0]    A_sub_0;
  wire       [7:0]    A_sub_1;
  wire       [7:0]    A_sub_2;
  wire       [7:0]    A_sub_3;
  wire       [7:0]    B_sub_0;
  wire       [7:0]    B_sub_1;
  wire       [7:0]    B_sub_2;
  wire       [7:0]    B_sub_3;
  reg        [3:0]    A_sgn;
  reg        [3:0]    B_sgn;
  wire       [11:0]   A_abs_0;
  wire       [11:0]   A_abs_1;
  wire       [11:0]   A_abs_2;
  wire       [11:0]   A_abs_3;
  wire       [11:0]   B_abs_0;
  wire       [11:0]   B_abs_1;
  wire       [11:0]   B_abs_2;
  wire       [11:0]   B_abs_3;
  reg        [47:0]   A_mul;
  reg        [47:0]   B_mul;
  wire       [23:0]   P_sub_0;
  wire       [23:0]   P_sub_1;
  wire       [23:0]   P_sub_2;
  wire       [23:0]   P_sub_3;
  reg        [3:0]    _zz_P_sgn;
  reg        [3:0]    _zz_P_sgn_1;
  reg        [3:0]    P_sgn;
  wire       [15:0]   P_abs_0;
  wire       [15:0]   P_abs_1;
  wire       [15:0]   P_abs_2;
  wire       [15:0]   P_abs_3;
  wire       [15:0]   P_int_0;
  wire       [15:0]   P_int_1;
  wire       [15:0]   P_int_2;
  wire       [15:0]   P_int_3;
  reg        [63:0]   P_out;
  wire       [7:0]    _zz_A_abs_0;
  wire       [7:0]    _zz_B_abs_0;
  wire       [7:0]    _zz_A_abs_1;
  wire       [7:0]    _zz_B_abs_1;
  wire       [7:0]    _zz_A_abs_2;
  wire       [7:0]    _zz_B_abs_2;
  wire       [7:0]    _zz_A_abs_3;
  wire       [7:0]    _zz_B_abs_3;
  wire                when_mulUnit_l92;
  reg        [63:0]   P_out_regNext;
  `ifndef SYNTHESIS
  reg [63:0] io_op_string;
  `endif


  assign _zz_A_abs_0_1 = (_zz_A_abs_0_2 + _zz_A_abs_0_4);
  assign _zz_A_abs_0_2 = (_zz_A_abs_0[7] ? _zz_A_abs_0_3 : _zz_A_abs_0);
  assign _zz_A_abs_0_3 = (~ _zz_A_abs_0);
  assign _zz_A_abs_0_5 = _zz_A_abs_0[7];
  assign _zz_A_abs_0_4 = {7'd0, _zz_A_abs_0_5};
  assign _zz_B_abs_0_1 = (_zz_B_abs_0_2 + _zz_B_abs_0_4);
  assign _zz_B_abs_0_2 = (_zz_B_abs_0[7] ? _zz_B_abs_0_3 : _zz_B_abs_0);
  assign _zz_B_abs_0_3 = (~ _zz_B_abs_0);
  assign _zz_B_abs_0_5 = _zz_B_abs_0[7];
  assign _zz_B_abs_0_4 = {7'd0, _zz_B_abs_0_5};
  assign _zz_P_int_0 = (- _zz_P_int_0_1);
  assign _zz_P_int_0_1 = P_abs_0;
  assign _zz_P_int_0_2 = P_abs_0;
  assign _zz_A_abs_1_1 = (_zz_A_abs_1_2 + _zz_A_abs_1_4);
  assign _zz_A_abs_1_2 = (_zz_A_abs_1[7] ? _zz_A_abs_1_3 : _zz_A_abs_1);
  assign _zz_A_abs_1_3 = (~ _zz_A_abs_1);
  assign _zz_A_abs_1_5 = _zz_A_abs_1[7];
  assign _zz_A_abs_1_4 = {7'd0, _zz_A_abs_1_5};
  assign _zz_B_abs_1_1 = (_zz_B_abs_1_2 + _zz_B_abs_1_4);
  assign _zz_B_abs_1_2 = (_zz_B_abs_1[7] ? _zz_B_abs_1_3 : _zz_B_abs_1);
  assign _zz_B_abs_1_3 = (~ _zz_B_abs_1);
  assign _zz_B_abs_1_5 = _zz_B_abs_1[7];
  assign _zz_B_abs_1_4 = {7'd0, _zz_B_abs_1_5};
  assign _zz_P_int_1 = (- _zz_P_int_1_1);
  assign _zz_P_int_1_1 = P_abs_1;
  assign _zz_P_int_1_2 = P_abs_1;
  assign _zz_A_abs_2_1 = (_zz_A_abs_2_2 + _zz_A_abs_2_4);
  assign _zz_A_abs_2_2 = (_zz_A_abs_2[7] ? _zz_A_abs_2_3 : _zz_A_abs_2);
  assign _zz_A_abs_2_3 = (~ _zz_A_abs_2);
  assign _zz_A_abs_2_5 = _zz_A_abs_2[7];
  assign _zz_A_abs_2_4 = {7'd0, _zz_A_abs_2_5};
  assign _zz_B_abs_2_1 = (_zz_B_abs_2_2 + _zz_B_abs_2_4);
  assign _zz_B_abs_2_2 = (_zz_B_abs_2[7] ? _zz_B_abs_2_3 : _zz_B_abs_2);
  assign _zz_B_abs_2_3 = (~ _zz_B_abs_2);
  assign _zz_B_abs_2_5 = _zz_B_abs_2[7];
  assign _zz_B_abs_2_4 = {7'd0, _zz_B_abs_2_5};
  assign _zz_P_int_2 = (- _zz_P_int_2_1);
  assign _zz_P_int_2_1 = P_abs_2;
  assign _zz_P_int_2_2 = P_abs_2;
  assign _zz_A_abs_3_1 = (_zz_A_abs_3_2 + _zz_A_abs_3_4);
  assign _zz_A_abs_3_2 = (_zz_A_abs_3[7] ? _zz_A_abs_3_3 : _zz_A_abs_3);
  assign _zz_A_abs_3_3 = (~ _zz_A_abs_3);
  assign _zz_A_abs_3_5 = _zz_A_abs_3[7];
  assign _zz_A_abs_3_4 = {7'd0, _zz_A_abs_3_5};
  assign _zz_B_abs_3_1 = (_zz_B_abs_3_2 + _zz_B_abs_3_4);
  assign _zz_B_abs_3_2 = (_zz_B_abs_3[7] ? _zz_B_abs_3_3 : _zz_B_abs_3);
  assign _zz_B_abs_3_3 = (~ _zz_B_abs_3);
  assign _zz_B_abs_3_5 = _zz_B_abs_3[7];
  assign _zz_B_abs_3_4 = {7'd0, _zz_B_abs_3_5};
  assign _zz_P_int_3 = (- _zz_P_int_3_1);
  assign _zz_P_int_3_1 = P_abs_3;
  assign _zz_P_int_3_2 = P_abs_3;
  mulSIMD multipler (
    .io_simd (multipler_io_simd   ), //i
    .io_A    (A_mul[47:0]         ), //i
    .io_B    (B_mul[47:0]         ), //i
    .io_P    (multipler_io_P[95:0]), //o
    .clk     (clk                 ), //i
    .resetn  (resetn              )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      ArithOp_FP32 : io_op_string = "FP32    ";
      ArithOp_FP16 : io_op_string = "FP16    ";
      ArithOp_FP16_MIX : io_op_string = "FP16_MIX";
      ArithOp_INT8 : io_op_string = "INT8    ";
      ArithOp_INT4 : io_op_string = "INT4    ";
      default : io_op_string = "????????";
    endcase
  end
  `endif

  assign A_sub_0 = io_A_mtsa[7 : 0];
  assign A_sub_1 = io_A_mtsa[15 : 8];
  assign A_sub_2 = io_A_mtsa[23 : 16];
  assign A_sub_3 = io_A_mtsa[31 : 24];
  assign B_sub_0 = io_B_mtsa[7 : 0];
  assign B_sub_1 = io_B_mtsa[15 : 8];
  assign B_sub_2 = io_B_mtsa[23 : 16];
  assign B_sub_3 = io_B_mtsa[31 : 24];
  assign multipler_io_simd = (io_op != ArithOp_FP32);
  assign P_sub_0 = multipler_io_P[23 : 0];
  assign P_sub_1 = multipler_io_P[47 : 24];
  assign P_sub_2 = multipler_io_P[71 : 48];
  assign P_sub_3 = multipler_io_P[95 : 72];
  always @(*) begin
    A_sgn[0] = A_sub_0[7];
    A_sgn[1] = A_sub_1[7];
    A_sgn[2] = A_sub_2[7];
    A_sgn[3] = A_sub_3[7];
  end

  always @(*) begin
    B_sgn[0] = B_sub_0[7];
    B_sgn[1] = B_sub_1[7];
    B_sgn[2] = B_sub_2[7];
    B_sgn[3] = B_sub_3[7];
  end

  assign _zz_A_abs_0 = A_sub_0;
  assign A_abs_0 = {4'b0000,_zz_A_abs_0_1};
  assign _zz_B_abs_0 = B_sub_0;
  assign B_abs_0 = {4'b0000,_zz_B_abs_0_1};
  assign P_abs_0 = P_sub_0[15 : 0];
  assign P_int_0 = (P_sgn[0] ? _zz_P_int_0 : _zz_P_int_0_2);
  assign _zz_A_abs_1 = A_sub_1;
  assign A_abs_1 = {4'b0000,_zz_A_abs_1_1};
  assign _zz_B_abs_1 = B_sub_1;
  assign B_abs_1 = {4'b0000,_zz_B_abs_1_1};
  assign P_abs_1 = P_sub_1[15 : 0];
  assign P_int_1 = (P_sgn[1] ? _zz_P_int_1 : _zz_P_int_1_2);
  assign _zz_A_abs_2 = A_sub_2;
  assign A_abs_2 = {4'b0000,_zz_A_abs_2_1};
  assign _zz_B_abs_2 = B_sub_2;
  assign B_abs_2 = {4'b0000,_zz_B_abs_2_1};
  assign P_abs_2 = P_sub_2[15 : 0];
  assign P_int_2 = (P_sgn[2] ? _zz_P_int_2 : _zz_P_int_2_2);
  assign _zz_A_abs_3 = A_sub_3;
  assign A_abs_3 = {4'b0000,_zz_A_abs_3_1};
  assign _zz_B_abs_3 = B_sub_3;
  assign B_abs_3 = {4'b0000,_zz_B_abs_3_1};
  assign P_abs_3 = P_sub_3[15 : 0];
  assign P_int_3 = (P_sgn[3] ? _zz_P_int_3 : _zz_P_int_3_2);
  assign when_mulUnit_l92 = ((io_op == ArithOp_INT8) || (io_op == ArithOp_INT4));
  always @(*) begin
    if(when_mulUnit_l92) begin
      A_mul = {A_abs_3,{A_abs_2,{A_abs_1,A_abs_0}}};
    end else begin
      A_mul = {16'h0,io_A_mtsa};
    end
  end

  always @(*) begin
    if(when_mulUnit_l92) begin
      B_mul = {B_abs_3,{B_abs_2,{B_abs_1,B_abs_0}}};
    end else begin
      B_mul = {16'h0,io_B_mtsa};
    end
  end

  always @(*) begin
    if(when_mulUnit_l92) begin
      P_out = {P_int_3,{P_int_2,{P_int_1,P_int_0}}};
    end else begin
      P_out = multipler_io_P[63 : 0];
    end
  end

  assign io_P_mtsa = P_out_regNext;
  always @(posedge clk) begin
    _zz_P_sgn <= (A_sgn ^ B_sgn);
    _zz_P_sgn_1 <= _zz_P_sgn;
    P_sgn <= _zz_P_sgn_1;
    P_out_regNext <= P_out;
  end


endmodule

//mulSIMD_16 replaced by mulSIMD

//mulSIMD_15 replaced by mulSIMD

//mulSIMD_14 replaced by mulSIMD

//mulSIMD_13 replaced by mulSIMD

//mulSIMD_12 replaced by mulSIMD

//mulSIMD_11 replaced by mulSIMD

//mulSIMD_10 replaced by mulSIMD

//mulSIMD_9 replaced by mulSIMD

//mulSIMD_8 replaced by mulSIMD

//mulSIMD_7 replaced by mulSIMD

//mulSIMD_6 replaced by mulSIMD

//mulSIMD_5 replaced by mulSIMD

//mulSIMD_4 replaced by mulSIMD

//mulSIMD_3 replaced by mulSIMD

//mulSIMD_2 replaced by mulSIMD

//mulSIMD_1 replaced by mulSIMD

//unPackUnit_1 replaced by unPackUnit

module unPackUnit (
  input  wire [1:0]    io_op,
  input  wire [31:0]   io_xf,
  output wire [31:0]   io_mtsa,
  output wire [7:0]    io_expn_0,
  output wire [7:0]    io_expn_1,
  output wire          io_sign_0,
  output wire          io_sign_1,
  output wire [1:0]    io_flag_0,
  output wire [1:0]    io_flag_1,
  input  wire          clk,
  input  wire          resetn
);
  localparam PackOp_INTx = 2'd0;
  localparam PackOp_FP32 = 2'd1;
  localparam PackOp_FP16 = 2'd2;
  localparam FpFlag_ZERO = 2'd0;
  localparam FpFlag_NORM = 2'd1;
  localparam FpFlag_INF = 2'd2;
  localparam FpFlag_NAN = 2'd3;

  wire       [7:0]    fp32_expn;
  wire       [22:0]   fp32_frac;
  wire                fp32_expnAllone;
  wire                fp32_expnEquZero;
  wire                fp32_fracEquZero;
  wire                fp32_S;
  reg        [7:0]    fp32_E;
  reg        [23:0]   fp32_M;
  reg        [1:0]    fp32_F;
  wire       [1:0]    _zz_fp32_F;
  wire       [1:0]    _zz_fp32_F_1;
  wire       [15:0]   _zz_fp16_0_expn;
  wire       [4:0]    fp16_0_expn;
  wire       [9:0]    fp16_0_frac;
  wire                fp16_0_expnAllone;
  wire                fp16_0_expnEquZero;
  wire                fp16_0_fracEquZero;
  wire                fp16_0_S;
  reg        [4:0]    fp16_0_E;
  reg        [10:0]   fp16_0_M;
  reg        [1:0]    fp16_0_F;
  wire       [1:0]    _zz_fp16_0_F;
  wire       [1:0]    _zz_fp16_0_F_1;
  wire       [15:0]   _zz_fp16_1_expn;
  wire       [4:0]    fp16_1_expn;
  wire       [9:0]    fp16_1_frac;
  wire                fp16_1_expnAllone;
  wire                fp16_1_expnEquZero;
  wire                fp16_1_fracEquZero;
  wire                fp16_1_S;
  reg        [4:0]    fp16_1_E;
  reg        [10:0]   fp16_1_M;
  reg        [1:0]    fp16_1_F;
  wire       [1:0]    _zz_fp16_1_F;
  wire       [1:0]    _zz_fp16_1_F_1;
  reg        [31:0]   mtsa;
  reg        [7:0]    expn_0;
  reg        [7:0]    expn_1;
  reg                 sign_0;
  reg                 sign_1;
  reg        [1:0]    flag_0;
  reg        [1:0]    flag_1;
  reg        [31:0]   mtsa_regNext;
  reg        [7:0]    expn_0_regNext;
  reg                 sign_0_regNext;
  reg        [1:0]    flag_0_regNext;
  reg        [7:0]    expn_1_regNext;
  reg                 sign_1_regNext;
  reg        [1:0]    flag_1_regNext;
  `ifndef SYNTHESIS
  reg [31:0] io_op_string;
  reg [31:0] io_flag_0_string;
  reg [31:0] io_flag_1_string;
  reg [31:0] fp32_F_string;
  reg [31:0] _zz_fp32_F_string;
  reg [31:0] _zz_fp32_F_1_string;
  reg [31:0] fp16_0_F_string;
  reg [31:0] _zz_fp16_0_F_string;
  reg [31:0] _zz_fp16_0_F_1_string;
  reg [31:0] fp16_1_F_string;
  reg [31:0] _zz_fp16_1_F_string;
  reg [31:0] _zz_fp16_1_F_1_string;
  reg [31:0] flag_0_string;
  reg [31:0] flag_1_string;
  reg [31:0] flag_0_regNext_string;
  reg [31:0] flag_1_regNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      PackOp_INTx : io_op_string = "INTx";
      PackOp_FP32 : io_op_string = "FP32";
      PackOp_FP16 : io_op_string = "FP16";
      default : io_op_string = "????";
    endcase
  end
  always @(*) begin
    case(io_flag_0)
      FpFlag_ZERO : io_flag_0_string = "ZERO";
      FpFlag_NORM : io_flag_0_string = "NORM";
      FpFlag_INF : io_flag_0_string = "INF ";
      FpFlag_NAN : io_flag_0_string = "NAN ";
      default : io_flag_0_string = "????";
    endcase
  end
  always @(*) begin
    case(io_flag_1)
      FpFlag_ZERO : io_flag_1_string = "ZERO";
      FpFlag_NORM : io_flag_1_string = "NORM";
      FpFlag_INF : io_flag_1_string = "INF ";
      FpFlag_NAN : io_flag_1_string = "NAN ";
      default : io_flag_1_string = "????";
    endcase
  end
  always @(*) begin
    case(fp32_F)
      FpFlag_ZERO : fp32_F_string = "ZERO";
      FpFlag_NORM : fp32_F_string = "NORM";
      FpFlag_INF : fp32_F_string = "INF ";
      FpFlag_NAN : fp32_F_string = "NAN ";
      default : fp32_F_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_fp32_F)
      FpFlag_ZERO : _zz_fp32_F_string = "ZERO";
      FpFlag_NORM : _zz_fp32_F_string = "NORM";
      FpFlag_INF : _zz_fp32_F_string = "INF ";
      FpFlag_NAN : _zz_fp32_F_string = "NAN ";
      default : _zz_fp32_F_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_fp32_F_1)
      FpFlag_ZERO : _zz_fp32_F_1_string = "ZERO";
      FpFlag_NORM : _zz_fp32_F_1_string = "NORM";
      FpFlag_INF : _zz_fp32_F_1_string = "INF ";
      FpFlag_NAN : _zz_fp32_F_1_string = "NAN ";
      default : _zz_fp32_F_1_string = "????";
    endcase
  end
  always @(*) begin
    case(fp16_0_F)
      FpFlag_ZERO : fp16_0_F_string = "ZERO";
      FpFlag_NORM : fp16_0_F_string = "NORM";
      FpFlag_INF : fp16_0_F_string = "INF ";
      FpFlag_NAN : fp16_0_F_string = "NAN ";
      default : fp16_0_F_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_fp16_0_F)
      FpFlag_ZERO : _zz_fp16_0_F_string = "ZERO";
      FpFlag_NORM : _zz_fp16_0_F_string = "NORM";
      FpFlag_INF : _zz_fp16_0_F_string = "INF ";
      FpFlag_NAN : _zz_fp16_0_F_string = "NAN ";
      default : _zz_fp16_0_F_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_fp16_0_F_1)
      FpFlag_ZERO : _zz_fp16_0_F_1_string = "ZERO";
      FpFlag_NORM : _zz_fp16_0_F_1_string = "NORM";
      FpFlag_INF : _zz_fp16_0_F_1_string = "INF ";
      FpFlag_NAN : _zz_fp16_0_F_1_string = "NAN ";
      default : _zz_fp16_0_F_1_string = "????";
    endcase
  end
  always @(*) begin
    case(fp16_1_F)
      FpFlag_ZERO : fp16_1_F_string = "ZERO";
      FpFlag_NORM : fp16_1_F_string = "NORM";
      FpFlag_INF : fp16_1_F_string = "INF ";
      FpFlag_NAN : fp16_1_F_string = "NAN ";
      default : fp16_1_F_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_fp16_1_F)
      FpFlag_ZERO : _zz_fp16_1_F_string = "ZERO";
      FpFlag_NORM : _zz_fp16_1_F_string = "NORM";
      FpFlag_INF : _zz_fp16_1_F_string = "INF ";
      FpFlag_NAN : _zz_fp16_1_F_string = "NAN ";
      default : _zz_fp16_1_F_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_fp16_1_F_1)
      FpFlag_ZERO : _zz_fp16_1_F_1_string = "ZERO";
      FpFlag_NORM : _zz_fp16_1_F_1_string = "NORM";
      FpFlag_INF : _zz_fp16_1_F_1_string = "INF ";
      FpFlag_NAN : _zz_fp16_1_F_1_string = "NAN ";
      default : _zz_fp16_1_F_1_string = "????";
    endcase
  end
  always @(*) begin
    case(flag_0)
      FpFlag_ZERO : flag_0_string = "ZERO";
      FpFlag_NORM : flag_0_string = "NORM";
      FpFlag_INF : flag_0_string = "INF ";
      FpFlag_NAN : flag_0_string = "NAN ";
      default : flag_0_string = "????";
    endcase
  end
  always @(*) begin
    case(flag_1)
      FpFlag_ZERO : flag_1_string = "ZERO";
      FpFlag_NORM : flag_1_string = "NORM";
      FpFlag_INF : flag_1_string = "INF ";
      FpFlag_NAN : flag_1_string = "NAN ";
      default : flag_1_string = "????";
    endcase
  end
  always @(*) begin
    case(flag_0_regNext)
      FpFlag_ZERO : flag_0_regNext_string = "ZERO";
      FpFlag_NORM : flag_0_regNext_string = "NORM";
      FpFlag_INF : flag_0_regNext_string = "INF ";
      FpFlag_NAN : flag_0_regNext_string = "NAN ";
      default : flag_0_regNext_string = "????";
    endcase
  end
  always @(*) begin
    case(flag_1_regNext)
      FpFlag_ZERO : flag_1_regNext_string = "ZERO";
      FpFlag_NORM : flag_1_regNext_string = "NORM";
      FpFlag_INF : flag_1_regNext_string = "INF ";
      FpFlag_NAN : flag_1_regNext_string = "NAN ";
      default : flag_1_regNext_string = "????";
    endcase
  end
  `endif

  assign fp32_expn = io_xf[30 : 23];
  assign fp32_frac = io_xf[22 : 0];
  assign fp32_expnAllone = (&fp32_expn);
  assign fp32_expnEquZero = (! (|fp32_expn));
  assign fp32_fracEquZero = (! (|fp32_frac));
  assign fp32_S = io_xf[31];
  always @(*) begin
    fp32_M = {1'b0,fp32_frac};
    if(fp32_expnAllone) begin
      fp32_M[23] = 1'b0;
    end else begin
      if(fp32_expnEquZero) begin
        fp32_M[23] = 1'b0;
      end else begin
        fp32_M[23] = 1'b1;
      end
    end
  end

  always @(*) begin
    if(fp32_expnAllone) begin
      fp32_E = fp32_expn;
    end else begin
      if(fp32_expnEquZero) begin
        fp32_E = 8'h01;
      end else begin
        fp32_E = fp32_expn;
      end
    end
  end

  assign _zz_fp32_F = (fp32_fracEquZero ? FpFlag_INF : FpFlag_NAN);
  always @(*) begin
    if(fp32_expnAllone) begin
      fp32_F = _zz_fp32_F;
    end else begin
      if(fp32_expnEquZero) begin
        fp32_F = _zz_fp32_F_1;
      end else begin
        fp32_F = FpFlag_NORM;
      end
    end
  end

  assign _zz_fp32_F_1 = (fp32_fracEquZero ? FpFlag_ZERO : FpFlag_NORM);
  assign _zz_fp16_0_expn = io_xf[15 : 0];
  assign fp16_0_expn = _zz_fp16_0_expn[14 : 10];
  assign fp16_0_frac = _zz_fp16_0_expn[9 : 0];
  assign fp16_0_expnAllone = (&fp16_0_expn);
  assign fp16_0_expnEquZero = (! (|fp16_0_expn));
  assign fp16_0_fracEquZero = (! (|fp16_0_frac));
  assign fp16_0_S = _zz_fp16_0_expn[15];
  always @(*) begin
    fp16_0_M = {1'b0,fp16_0_frac};
    if(fp16_0_expnAllone) begin
      fp16_0_M[10] = 1'b0;
    end else begin
      if(fp16_0_expnEquZero) begin
        fp16_0_M[10] = 1'b0;
      end else begin
        fp16_0_M[10] = 1'b1;
      end
    end
  end

  always @(*) begin
    if(fp16_0_expnAllone) begin
      fp16_0_E = fp16_0_expn;
    end else begin
      if(fp16_0_expnEquZero) begin
        fp16_0_E = 5'h01;
      end else begin
        fp16_0_E = fp16_0_expn;
      end
    end
  end

  assign _zz_fp16_0_F = (fp16_0_fracEquZero ? FpFlag_INF : FpFlag_NAN);
  always @(*) begin
    if(fp16_0_expnAllone) begin
      fp16_0_F = _zz_fp16_0_F;
    end else begin
      if(fp16_0_expnEquZero) begin
        fp16_0_F = _zz_fp16_0_F_1;
      end else begin
        fp16_0_F = FpFlag_NORM;
      end
    end
  end

  assign _zz_fp16_0_F_1 = (fp16_0_fracEquZero ? FpFlag_ZERO : FpFlag_NORM);
  assign _zz_fp16_1_expn = io_xf[31 : 16];
  assign fp16_1_expn = _zz_fp16_1_expn[14 : 10];
  assign fp16_1_frac = _zz_fp16_1_expn[9 : 0];
  assign fp16_1_expnAllone = (&fp16_1_expn);
  assign fp16_1_expnEquZero = (! (|fp16_1_expn));
  assign fp16_1_fracEquZero = (! (|fp16_1_frac));
  assign fp16_1_S = _zz_fp16_1_expn[15];
  always @(*) begin
    fp16_1_M = {1'b0,fp16_1_frac};
    if(fp16_1_expnAllone) begin
      fp16_1_M[10] = 1'b0;
    end else begin
      if(fp16_1_expnEquZero) begin
        fp16_1_M[10] = 1'b0;
      end else begin
        fp16_1_M[10] = 1'b1;
      end
    end
  end

  always @(*) begin
    if(fp16_1_expnAllone) begin
      fp16_1_E = fp16_1_expn;
    end else begin
      if(fp16_1_expnEquZero) begin
        fp16_1_E = 5'h01;
      end else begin
        fp16_1_E = fp16_1_expn;
      end
    end
  end

  assign _zz_fp16_1_F = (fp16_1_fracEquZero ? FpFlag_INF : FpFlag_NAN);
  always @(*) begin
    if(fp16_1_expnAllone) begin
      fp16_1_F = _zz_fp16_1_F;
    end else begin
      if(fp16_1_expnEquZero) begin
        fp16_1_F = _zz_fp16_1_F_1;
      end else begin
        fp16_1_F = FpFlag_NORM;
      end
    end
  end

  assign _zz_fp16_1_F_1 = (fp16_1_fracEquZero ? FpFlag_ZERO : FpFlag_NORM);
  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        mtsa = {8'h0,fp32_M};
      end
      PackOp_FP16 : begin
        mtsa = {{{{8'h0,fp16_1_M},1'b0},fp16_0_M},1'b0};
      end
      default : begin
        mtsa = io_xf;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        expn_0 = fp32_E;
      end
      PackOp_FP16 : begin
        expn_0 = {3'b000,fp16_0_E};
      end
      default : begin
        expn_0 = 8'h0;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        sign_0 = fp32_S;
      end
      PackOp_FP16 : begin
        sign_0 = fp16_0_S;
      end
      default : begin
        sign_0 = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        flag_0 = fp32_F;
      end
      PackOp_FP16 : begin
        flag_0 = fp16_0_F;
      end
      default : begin
        flag_0 = FpFlag_ZERO;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        expn_1 = 8'h0;
      end
      PackOp_FP16 : begin
        expn_1 = {3'b000,fp16_1_E};
      end
      default : begin
        expn_1 = 8'h0;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        sign_1 = 1'b0;
      end
      PackOp_FP16 : begin
        sign_1 = fp16_1_S;
      end
      default : begin
        sign_1 = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(io_op)
      PackOp_FP32 : begin
        flag_1 = FpFlag_ZERO;
      end
      PackOp_FP16 : begin
        flag_1 = fp16_1_F;
      end
      default : begin
        flag_1 = FpFlag_ZERO;
      end
    endcase
  end

  assign io_mtsa = mtsa_regNext;
  assign io_expn_0 = expn_0_regNext;
  assign io_sign_0 = sign_0_regNext;
  assign io_flag_0 = flag_0_regNext;
  assign io_expn_1 = expn_1_regNext;
  assign io_sign_1 = sign_1_regNext;
  assign io_flag_1 = flag_1_regNext;
  always @(posedge clk) begin
    mtsa_regNext <= mtsa;
    expn_0_regNext <= expn_0;
    sign_0_regNext <= sign_0;
    flag_0_regNext <= flag_0;
    expn_1_regNext <= expn_1;
    sign_1_regNext <= sign_1;
    flag_1_regNext <= flag_1;
  end


endmodule

module expnAddUnit (
  input  wire [2:0]    io_op,
  input  wire [7:0]    io_A_expn,
  input  wire          io_A_sign,
  input  wire [1:0]    io_A_flag,
  input  wire [7:0]    io_B_expn,
  input  wire          io_B_sign,
  input  wire [1:0]    io_B_flag,
  output wire [9:0]    io_P_expn,
  output wire          io_P_sign,
  output wire [1:0]    io_P_flag,
  input  wire          clk,
  input  wire          resetn
);
  localparam ArithOp_FP32 = 3'd1;
  localparam ArithOp_FP16 = 3'd2;
  localparam ArithOp_FP16_MIX = 3'd3;
  localparam ArithOp_INT8 = 3'd4;
  localparam ArithOp_INT4 = 3'd5;
  localparam FpFlag_ZERO = 2'd0;
  localparam FpFlag_NORM = 2'd1;
  localparam FpFlag_INF = 2'd2;
  localparam FpFlag_NAN = 2'd3;

  wire       [9:0]    _zz_P_expn;
  wire       [8:0]    _zz_P_expn_1;
  wire       [9:0]    _zz_P_expn_2;
  reg        [7:0]    Bias;
  wire       [9:0]    P_expn;
  wire                P_sign;
  reg        [1:0]    P_flag;
  wire                when_mulUnit_l134;
  wire                when_mulUnit_l136;
  wire                when_mulUnit_l138;
  reg        [9:0]    P_expn_regNext;
  reg                 P_sign_regNext;
  reg        [1:0]    P_flag_regNext;
  `ifndef SYNTHESIS
  reg [63:0] io_op_string;
  reg [31:0] io_A_flag_string;
  reg [31:0] io_B_flag_string;
  reg [31:0] io_P_flag_string;
  reg [31:0] P_flag_string;
  reg [31:0] P_flag_regNext_string;
  `endif


  assign _zz_P_expn = {1'b0,_zz_P_expn_1};
  assign _zz_P_expn_1 = ({1'b0,io_A_expn} + {1'b0,io_B_expn});
  assign _zz_P_expn_2 = {{2{Bias[7]}}, Bias};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      ArithOp_FP32 : io_op_string = "FP32    ";
      ArithOp_FP16 : io_op_string = "FP16    ";
      ArithOp_FP16_MIX : io_op_string = "FP16_MIX";
      ArithOp_INT8 : io_op_string = "INT8    ";
      ArithOp_INT4 : io_op_string = "INT4    ";
      default : io_op_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_A_flag)
      FpFlag_ZERO : io_A_flag_string = "ZERO";
      FpFlag_NORM : io_A_flag_string = "NORM";
      FpFlag_INF : io_A_flag_string = "INF ";
      FpFlag_NAN : io_A_flag_string = "NAN ";
      default : io_A_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(io_B_flag)
      FpFlag_ZERO : io_B_flag_string = "ZERO";
      FpFlag_NORM : io_B_flag_string = "NORM";
      FpFlag_INF : io_B_flag_string = "INF ";
      FpFlag_NAN : io_B_flag_string = "NAN ";
      default : io_B_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(io_P_flag)
      FpFlag_ZERO : io_P_flag_string = "ZERO";
      FpFlag_NORM : io_P_flag_string = "NORM";
      FpFlag_INF : io_P_flag_string = "INF ";
      FpFlag_NAN : io_P_flag_string = "NAN ";
      default : io_P_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(P_flag)
      FpFlag_ZERO : P_flag_string = "ZERO";
      FpFlag_NORM : P_flag_string = "NORM";
      FpFlag_INF : P_flag_string = "INF ";
      FpFlag_NAN : P_flag_string = "NAN ";
      default : P_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(P_flag_regNext)
      FpFlag_ZERO : P_flag_regNext_string = "ZERO";
      FpFlag_NORM : P_flag_regNext_string = "NORM";
      FpFlag_INF : P_flag_regNext_string = "INF ";
      FpFlag_NAN : P_flag_regNext_string = "NAN ";
      default : P_flag_regNext_string = "????";
    endcase
  end
  `endif

  always @(*) begin
    case(io_op)
      ArithOp_FP32 : begin
        Bias = 8'h81;
      end
      ArithOp_FP16 : begin
        Bias = 8'hf1;
      end
      ArithOp_FP16_MIX : begin
        Bias = 8'h61;
      end
      default : begin
        Bias = 8'h0;
      end
    endcase
  end

  assign P_expn = ($signed(_zz_P_expn) + $signed(_zz_P_expn_2));
  assign P_sign = (io_A_sign ^ io_B_sign);
  assign when_mulUnit_l134 = ((((io_A_flag == FpFlag_NAN) || (io_B_flag == FpFlag_NAN)) || ((io_A_flag == FpFlag_ZERO) && (io_B_flag == FpFlag_INF))) || ((io_A_flag == FpFlag_INF) && (io_B_flag == FpFlag_ZERO)));
  always @(*) begin
    if(when_mulUnit_l134) begin
      P_flag = FpFlag_NAN;
    end else begin
      if(when_mulUnit_l136) begin
        P_flag = FpFlag_INF;
      end else begin
        if(when_mulUnit_l138) begin
          P_flag = FpFlag_ZERO;
        end else begin
          P_flag = FpFlag_NORM;
        end
      end
    end
  end

  assign when_mulUnit_l136 = ((io_A_flag == FpFlag_INF) || (io_B_flag == FpFlag_INF));
  assign when_mulUnit_l138 = ((io_A_flag == FpFlag_ZERO) || (io_B_flag == FpFlag_ZERO));
  assign io_P_expn = P_expn_regNext;
  assign io_P_sign = P_sign_regNext;
  assign io_P_flag = P_flag_regNext;
  always @(posedge clk) begin
    P_expn_regNext <= P_expn;
    P_sign_regNext <= P_sign;
    P_flag_regNext <= P_flag;
  end


endmodule

module mulSIMD (
  input  wire          io_simd,
  input  wire [47:0]   io_A,
  input  wire [47:0]   io_B,
  output wire [95:0]   io_P,
  input  wire          clk,
  input  wire          resetn
);

  wire       [47:0]   _zz_accumP;
  wire       [47:0]   _zz_accumP_1;
  wire       [35:0]   _zz_accumP_2;
  wire       [47:0]   _zz_accumP_3;
  wire       [35:0]   _zz_accumP_4;
  wire       [11:0]   vecA_0;
  wire       [11:0]   vecA_1;
  wire       [11:0]   vecA_2;
  wire       [11:0]   vecA_3;
  wire       [11:0]   vecB_0;
  wire       [11:0]   vecB_1;
  wire       [11:0]   vecB_2;
  wire       [11:0]   vecB_3;
  reg        [11:0]   regA_0;
  reg        [11:0]   regA_1;
  reg        [11:0]   regA_2;
  reg        [11:0]   regA_3;
  reg        [11:0]   regB_0;
  reg        [11:0]   regB_1;
  reg        [11:0]   regB_2;
  reg        [11:0]   regB_3;
  reg        [23:0]   regP_0;
  reg        [23:0]   regP_1;
  reg        [23:0]   regP_2;
  reg        [23:0]   regP_3;
  wire       [47:0]   accumP;
  wire       [23:0]   vecAcc_0;
  wire       [23:0]   vecAcc_1;
  reg        [23:0]   regQ_0;
  reg        [23:0]   regQ_1;
  reg        [23:0]   regQ_2;
  reg        [23:0]   regQ_3;

  assign _zz_accumP = ({regP_1,regP_0} + _zz_accumP_1);
  assign _zz_accumP_2 = {regP_2,12'h0};
  assign _zz_accumP_1 = {12'd0, _zz_accumP_2};
  assign _zz_accumP_4 = {regP_3,12'h0};
  assign _zz_accumP_3 = {12'd0, _zz_accumP_4};
  assign vecA_0 = io_A[11 : 0];
  assign vecA_1 = io_A[23 : 12];
  assign vecA_2 = io_A[35 : 24];
  assign vecA_3 = io_A[47 : 36];
  assign vecB_0 = io_B[11 : 0];
  assign vecB_1 = io_B[23 : 12];
  assign vecB_2 = io_B[35 : 24];
  assign vecB_3 = io_B[47 : 36];
  assign accumP = (_zz_accumP + _zz_accumP_3);
  assign vecAcc_0 = accumP[23 : 0];
  assign vecAcc_1 = accumP[47 : 24];
  assign io_P = {{{regQ_3,regQ_2},regQ_1},regQ_0};
  always @(posedge clk) begin
    regA_0 <= vecA_0;
    regA_1 <= vecA_1;
    regA_2 <= (io_simd ? vecA_2 : vecA_0);
    regA_3 <= (io_simd ? vecA_3 : vecA_1);
    regB_0 <= vecB_0;
    regB_1 <= vecB_1;
    regB_2 <= (io_simd ? vecB_2 : vecB_1);
    regB_3 <= (io_simd ? vecB_3 : vecB_0);
    regP_0 <= (regA_0 * regB_0);
    regP_1 <= (regA_1 * regB_1);
    regP_2 <= (regA_2 * regB_2);
    regP_3 <= (regA_3 * regB_3);
    regQ_0 <= (io_simd ? regP_0 : vecAcc_0);
    regQ_1 <= (io_simd ? regP_1 : vecAcc_1);
    regQ_2 <= (io_simd ? regP_2 : 24'h0);
    regQ_3 <= (io_simd ? regP_3 : 24'h0);
  end


endmodule
