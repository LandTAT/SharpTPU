// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : axi4LiteFactory
// Git hash  : 138fc25b9c0b76cee948ca0dbc01d174dfdce2bc

`timescale 1ns/1ps

module axi4LiteFactory (
  input  wire          aLiteCtrl_awvalid,
  output wire          aLiteCtrl_awready,
  input  wire [31:0]   aLiteCtrl_awaddr,
  input  wire [2:0]    aLiteCtrl_awprot,
  input  wire          aLiteCtrl_wvalid,
  output wire          aLiteCtrl_wready,
  input  wire [31:0]   aLiteCtrl_wdata,
  input  wire [3:0]    aLiteCtrl_wstrb,
  output wire          aLiteCtrl_bvalid,
  input  wire          aLiteCtrl_bready,
  output wire [1:0]    aLiteCtrl_bresp,
  input  wire          aLiteCtrl_arvalid,
  output wire          aLiteCtrl_arready,
  input  wire [31:0]   aLiteCtrl_araddr,
  input  wire [2:0]    aLiteCtrl_arprot,
  output wire          aLiteCtrl_rvalid,
  input  wire          aLiteCtrl_rready,
  output wire [31:0]   aLiteCtrl_rdata,
  output wire [1:0]    aLiteCtrl_rresp,
  output reg           start,
  input  wire [31:0]   field,
  output reg  [39:0]   addrA,
  output reg  [39:0]   addrB,
  output reg  [39:0]   addrC,
  output reg  [39:0]   addrD,
  input  wire          clk,
  input  wire          resetn
);

  wire                busCtrl_readErrorFlag;
  wire                busCtrl_writeErrorFlag;
  wire                busCtrl_readHaltRequest;
  wire                busCtrl_writeHaltRequest;
  wire                busCtrl_writeJoinEvent_valid;
  wire                busCtrl_writeJoinEvent_ready;
  wire                busCtrl_writeOccur;
  reg        [1:0]    busCtrl_writeRsp_resp;
  wire                busCtrl_writeJoinEvent_translated_valid;
  wire                busCtrl_writeJoinEvent_translated_ready;
  wire       [1:0]    busCtrl_writeJoinEvent_translated_payload_resp;
  wire                _zz_busCtrl_writeJoinEvent_translated_ready;
  wire                busCtrl_writeJoinEvent_translated_haltWhen_valid;
  wire                busCtrl_writeJoinEvent_translated_haltWhen_ready;
  wire       [1:0]    busCtrl_writeJoinEvent_translated_haltWhen_payload_resp;
  wire                busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  wire                busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_ready;
  wire       [1:0]    busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  reg                 busCtrl_writeJoinEvent_translated_haltWhen_rValid;
  wire                busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_fire;
  reg        [1:0]    busCtrl_writeJoinEvent_translated_haltWhen_rData_resp;
  wire                busCtrl_readDataStage_valid;
  wire                busCtrl_readDataStage_ready;
  wire       [31:0]   busCtrl_readDataStage_payload_addr;
  wire       [2:0]    busCtrl_readDataStage_payload_prot;
  reg                 aLiteCtrl_ar_rValid;
  wire                busCtrl_readDataStage_fire;
  reg        [31:0]   aLiteCtrl_ar_rData_addr;
  reg        [2:0]    aLiteCtrl_ar_rData_prot;
  reg        [31:0]   busCtrl_readRsp_data;
  reg        [1:0]    busCtrl_readRsp_resp;
  wire                _zz_busCtrl_readDataStage_ready;
  wire                busCtrl_readDataStage_haltWhen_valid;
  wire                busCtrl_readDataStage_haltWhen_ready;
  wire       [31:0]   busCtrl_readDataStage_haltWhen_payload_addr;
  wire       [2:0]    busCtrl_readDataStage_haltWhen_payload_prot;
  wire                busCtrl_readDataStage_haltWhen_translated_valid;
  wire                busCtrl_readDataStage_haltWhen_translated_ready;
  wire       [31:0]   busCtrl_readDataStage_haltWhen_translated_payload_data;
  wire       [1:0]    busCtrl_readDataStage_haltWhen_translated_payload_resp;
  wire       [31:0]   busCtrl_readAddressMasked;
  wire       [31:0]   busCtrl_writeAddressMasked;
  wire                busCtrl_readOccur;

  assign busCtrl_readErrorFlag = 1'b0;
  assign busCtrl_writeErrorFlag = 1'b0;
  assign busCtrl_readHaltRequest = 1'b0;
  assign busCtrl_writeHaltRequest = 1'b0;
  assign busCtrl_writeOccur = (busCtrl_writeJoinEvent_valid && busCtrl_writeJoinEvent_ready);
  assign busCtrl_writeJoinEvent_valid = (aLiteCtrl_awvalid && aLiteCtrl_wvalid);
  assign aLiteCtrl_awready = busCtrl_writeOccur;
  assign aLiteCtrl_wready = busCtrl_writeOccur;
  assign busCtrl_writeJoinEvent_translated_valid = busCtrl_writeJoinEvent_valid;
  assign busCtrl_writeJoinEvent_ready = busCtrl_writeJoinEvent_translated_ready;
  assign busCtrl_writeJoinEvent_translated_payload_resp = busCtrl_writeRsp_resp;
  assign _zz_busCtrl_writeJoinEvent_translated_ready = (! busCtrl_writeHaltRequest);
  assign busCtrl_writeJoinEvent_translated_haltWhen_valid = (busCtrl_writeJoinEvent_translated_valid && _zz_busCtrl_writeJoinEvent_translated_ready);
  assign busCtrl_writeJoinEvent_translated_ready = (busCtrl_writeJoinEvent_translated_haltWhen_ready && _zz_busCtrl_writeJoinEvent_translated_ready);
  assign busCtrl_writeJoinEvent_translated_haltWhen_payload_resp = busCtrl_writeJoinEvent_translated_payload_resp;
  assign busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_fire = (busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_valid && busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_ready);
  assign busCtrl_writeJoinEvent_translated_haltWhen_ready = (! busCtrl_writeJoinEvent_translated_haltWhen_rValid);
  assign busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_valid = busCtrl_writeJoinEvent_translated_haltWhen_rValid;
  assign busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp = busCtrl_writeJoinEvent_translated_haltWhen_rData_resp;
  assign aLiteCtrl_bvalid = busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  assign busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_ready = aLiteCtrl_bready;
  assign aLiteCtrl_bresp = busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  assign busCtrl_readDataStage_fire = (busCtrl_readDataStage_valid && busCtrl_readDataStage_ready);
  assign aLiteCtrl_arready = (! aLiteCtrl_ar_rValid);
  assign busCtrl_readDataStage_valid = aLiteCtrl_ar_rValid;
  assign busCtrl_readDataStage_payload_addr = aLiteCtrl_ar_rData_addr;
  assign busCtrl_readDataStage_payload_prot = aLiteCtrl_ar_rData_prot;
  assign _zz_busCtrl_readDataStage_ready = (! busCtrl_readHaltRequest);
  assign busCtrl_readDataStage_haltWhen_valid = (busCtrl_readDataStage_valid && _zz_busCtrl_readDataStage_ready);
  assign busCtrl_readDataStage_ready = (busCtrl_readDataStage_haltWhen_ready && _zz_busCtrl_readDataStage_ready);
  assign busCtrl_readDataStage_haltWhen_payload_addr = busCtrl_readDataStage_payload_addr;
  assign busCtrl_readDataStage_haltWhen_payload_prot = busCtrl_readDataStage_payload_prot;
  assign busCtrl_readDataStage_haltWhen_translated_valid = busCtrl_readDataStage_haltWhen_valid;
  assign busCtrl_readDataStage_haltWhen_ready = busCtrl_readDataStage_haltWhen_translated_ready;
  assign busCtrl_readDataStage_haltWhen_translated_payload_data = busCtrl_readRsp_data;
  assign busCtrl_readDataStage_haltWhen_translated_payload_resp = busCtrl_readRsp_resp;
  assign aLiteCtrl_rvalid = busCtrl_readDataStage_haltWhen_translated_valid;
  assign busCtrl_readDataStage_haltWhen_translated_ready = aLiteCtrl_rready;
  assign aLiteCtrl_rdata = busCtrl_readDataStage_haltWhen_translated_payload_data;
  assign aLiteCtrl_rresp = busCtrl_readDataStage_haltWhen_translated_payload_resp;
  always @(*) begin
    if(busCtrl_writeErrorFlag) begin
      busCtrl_writeRsp_resp = 2'b10;
    end else begin
      busCtrl_writeRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    if(busCtrl_readErrorFlag) begin
      busCtrl_readRsp_resp = 2'b10;
    end else begin
      busCtrl_readRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    busCtrl_readRsp_data = 32'h0;
    case(busCtrl_readAddressMasked)
      32'h0 : begin
        busCtrl_readRsp_data[0 : 0] = start;
      end
      32'h00000004 : begin
        busCtrl_readRsp_data[31 : 0] = field;
      end
      32'h00000008 : begin
        busCtrl_readRsp_data[31 : 0] = addrA[31 : 0];
      end
      32'h0000000c : begin
        busCtrl_readRsp_data[7 : 0] = addrA[39 : 32];
      end
      32'h00000010 : begin
        busCtrl_readRsp_data[31 : 0] = addrB[31 : 0];
      end
      32'h00000014 : begin
        busCtrl_readRsp_data[7 : 0] = addrB[39 : 32];
      end
      32'h00000018 : begin
        busCtrl_readRsp_data[31 : 0] = addrC[31 : 0];
      end
      32'h0000001c : begin
        busCtrl_readRsp_data[7 : 0] = addrC[39 : 32];
      end
      32'h00000020 : begin
        busCtrl_readRsp_data[31 : 0] = addrD[31 : 0];
      end
      32'h00000024 : begin
        busCtrl_readRsp_data[7 : 0] = addrD[39 : 32];
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_readAddressMasked = (busCtrl_readDataStage_payload_addr & (~ 32'h00000003));
  assign busCtrl_writeAddressMasked = (aLiteCtrl_awaddr & (~ 32'h00000003));
  assign busCtrl_readOccur = (aLiteCtrl_rvalid && aLiteCtrl_rready);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      start <= 1'b0;
      addrA <= 40'h0;
      addrB <= 40'h0;
      addrC <= 40'h0;
      addrD <= 40'h0;
      busCtrl_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      aLiteCtrl_ar_rValid <= 1'b0;
    end else begin
      start <= 1'b0;
      if(busCtrl_writeJoinEvent_translated_haltWhen_valid) begin
        busCtrl_writeJoinEvent_translated_haltWhen_rValid <= 1'b1;
      end
      if(busCtrl_writeJoinEvent_translated_haltWhen_halfPipe_fire) begin
        busCtrl_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      end
      if(aLiteCtrl_arvalid) begin
        aLiteCtrl_ar_rValid <= 1'b1;
      end
      if(busCtrl_readDataStage_fire) begin
        aLiteCtrl_ar_rValid <= 1'b0;
      end
      case(busCtrl_writeAddressMasked)
        32'h0 : begin
          if(busCtrl_writeOccur) begin
            start <= aLiteCtrl_wdata[0];
          end
        end
        32'h00000008 : begin
          if(busCtrl_writeOccur) begin
            addrA[31 : 0] <= aLiteCtrl_wdata[31 : 0];
          end
        end
        32'h0000000c : begin
          if(busCtrl_writeOccur) begin
            addrA[39 : 32] <= aLiteCtrl_wdata[7 : 0];
          end
        end
        32'h00000010 : begin
          if(busCtrl_writeOccur) begin
            addrB[31 : 0] <= aLiteCtrl_wdata[31 : 0];
          end
        end
        32'h00000014 : begin
          if(busCtrl_writeOccur) begin
            addrB[39 : 32] <= aLiteCtrl_wdata[7 : 0];
          end
        end
        32'h00000018 : begin
          if(busCtrl_writeOccur) begin
            addrC[31 : 0] <= aLiteCtrl_wdata[31 : 0];
          end
        end
        32'h0000001c : begin
          if(busCtrl_writeOccur) begin
            addrC[39 : 32] <= aLiteCtrl_wdata[7 : 0];
          end
        end
        32'h00000020 : begin
          if(busCtrl_writeOccur) begin
            addrD[31 : 0] <= aLiteCtrl_wdata[31 : 0];
          end
        end
        32'h00000024 : begin
          if(busCtrl_writeOccur) begin
            addrD[39 : 32] <= aLiteCtrl_wdata[7 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(busCtrl_writeJoinEvent_translated_haltWhen_ready) begin
      busCtrl_writeJoinEvent_translated_haltWhen_rData_resp <= busCtrl_writeJoinEvent_translated_haltWhen_payload_resp;
    end
    if(aLiteCtrl_arready) begin
      aLiteCtrl_ar_rData_addr <= aLiteCtrl_araddr;
      aLiteCtrl_ar_rData_prot <= aLiteCtrl_arprot;
    end
  end


endmodule
