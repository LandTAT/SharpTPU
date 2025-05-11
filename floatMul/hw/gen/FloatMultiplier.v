// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : FloatMultiplier
// Git hash  : 577032a90a6829d01ed4a83667360bfcdadccdae

`timescale 1ns/1ps

module FloatMultiplier (
  input  wire [31:0]   io_xf,
  input  wire [31:0]   io_yf,
  output wire [31:0]   io_zf,
  input  wire          clk,
  input  wire          resetn
);
  localparam FloatFlag_ZERO = 2'd0;
  localparam FloatFlag_NORM = 2'd1;
  localparam FloatFlag_INF = 2'd2;
  localparam FloatFlag_NAN = 2'd3;

  wire       [8:0]    _zz_n2_m_expn;
  wire       [9:0]    _zz_n2_m_expn_1;
  wire       [7:0]    _zz_n2_m_expn_2;
  wire       [24:0]   _zz_n3_mtsa_round;
  wire       [1:0]    _zz_n3_mtsa_round_1;
  wire       [9:0]    _zz_when_FloatMultiplier_l144;
  wire       [9:0]    _zz_when_FloatMultiplier_l146;
  reg                 n4_n2_SIGN_M;
  reg        [1:0]    n3_n2_FLAG_M;
  reg                 n3_n2_SIGN_M;
  reg        [22:0]   n5_n4_FRAC_M;
  reg        [7:0]    n5_n4_EXPN_M;
  reg                 n5_n2_SIGN_M;
  wire       [1:0]    n4_FLAG_M;
  wire       [22:0]   n4_FRAC_M;
  wire       [7:0]    n4_EXPN_M;
  reg        [23:0]   n4_n3_MTSA_M;
  reg        [9:0]    n4_n3_EXPN_M;
  reg        [1:0]    n4_n2_FLAG_M;
  wire       [23:0]   n3_MTSA_M;
  wire       [9:0]    n3_EXPN_M;
  reg        [9:0]    n3_n2_EXPN_M;
  reg        [47:0]   n3_n2_MTSA_M;
  wire       [1:0]    n2_FLAG_M;
  wire       [47:0]   n2_MTSA_M;
  wire       [9:0]    n2_EXPN_M;
  wire                n2_SIGN_M;
  reg        [1:0]    n2_n1_FLAG_Y;
  reg        [1:0]    n2_n1_FLAG_X;
  reg        [7:0]    n2_n1_EXPN_Y;
  reg        [7:0]    n2_n1_EXPN_X;
  reg        [23:0]   n2_n1_MTSA_Y;
  reg        [23:0]   n2_n1_MTSA_X;
  reg                 n2_n1_SIGN_Y;
  reg                 n2_n1_SIGN_X;
  wire       [1:0]    n1_FLAG_Y;
  wire       [23:0]   n1_MTSA_Y;
  wire       [7:0]    n1_EXPN_Y;
  wire                n1_SIGN_Y;
  wire       [1:0]    n1_FLAG_X;
  wire       [23:0]   n1_MTSA_X;
  wire       [7:0]    n1_EXPN_X;
  wire                n1_SIGN_X;
  reg        [31:0]   n1_n0_YIN;
  reg        [31:0]   n1_n0_XIN;
  wire       [31:0]   n0_YIN;
  wire       [31:0]   n0_XIN;
  wire                n1_xUpack_sign;
  wire       [7:0]    n1_xUpack_expn;
  wire       [22:0]   n1_xUpack_frac;
  wire       [23:0]   n1_xUpack_mtsa;
  reg        [1:0]    n1_xUpack_flag;
  wire                n1_xUpack_expnAllone;
  wire                n1_xUpack_expnEquZero;
  wire                n1_xUpack_fracEquZero;
  wire       [1:0]    _zz_n1_xUpack_flag;
  wire       [1:0]    _zz_n1_xUpack_flag_1;
  wire                n1_yUpack_sign;
  wire       [7:0]    n1_yUpack_expn;
  wire       [22:0]   n1_yUpack_frac;
  wire       [23:0]   n1_yUpack_mtsa;
  reg        [1:0]    n1_yUpack_flag;
  wire                n1_yUpack_expnAllone;
  wire                n1_yUpack_expnEquZero;
  wire                n1_yUpack_fracEquZero;
  wire       [1:0]    _zz_n1_yUpack_flag;
  wire       [1:0]    _zz_n1_yUpack_flag_1;
  wire                n2_m_sign;
  wire       [47:0]   n2_m_mtsa;
  wire       [9:0]    n2_m_expn;
  reg        [1:0]    n2_m_flag;
  wire                when_FloatMultiplier_l83;
  wire                when_FloatMultiplier_l85;
  wire                when_FloatMultiplier_l87;
  reg        [46:0]   n3_mtsa_norm_1;
  reg        [9:0]    n3_expn_norm_1;
  wire                when_FloatMultiplier_l105;
  reg        [24:0]   n3_mtsa_round;
  wire       [23:0]   n3_mtsa_chop;
  wire                n3_round_bit;
  wire       [21:0]   n3_stick_bit;
  wire                when_FloatMultiplier_l117;
  reg        [23:0]   n3_mtsa_norm_2;
  reg        [9:0]    n3_expn_norm_2;
  wire                when_FloatMultiplier_l125;
  reg        [22:0]   n4_frac;
  reg        [7:0]    n4_expn;
  reg        [1:0]    n4_flag;
  wire                when_FloatMultiplier_l143;
  wire                when_FloatMultiplier_l144;
  wire                when_FloatMultiplier_l146;
  `ifndef SYNTHESIS
  reg [31:0] n3_n2_FLAG_M_string;
  reg [31:0] n4_FLAG_M_string;
  reg [31:0] n4_n2_FLAG_M_string;
  reg [31:0] n2_FLAG_M_string;
  reg [31:0] n2_n1_FLAG_Y_string;
  reg [31:0] n2_n1_FLAG_X_string;
  reg [31:0] n1_FLAG_Y_string;
  reg [31:0] n1_FLAG_X_string;
  reg [31:0] n1_xUpack_flag_string;
  reg [31:0] _zz_n1_xUpack_flag_string;
  reg [31:0] _zz_n1_xUpack_flag_1_string;
  reg [31:0] n1_yUpack_flag_string;
  reg [31:0] _zz_n1_yUpack_flag_string;
  reg [31:0] _zz_n1_yUpack_flag_1_string;
  reg [31:0] n2_m_flag_string;
  reg [31:0] n4_flag_string;
  `endif


  assign _zz_n2_m_expn = ({1'b0,n2_n1_EXPN_X} + {1'b0,n2_n1_EXPN_Y});
  assign _zz_n2_m_expn_2 = {1'b0,7'h7f};
  assign _zz_n2_m_expn_1 = {2'd0, _zz_n2_m_expn_2};
  assign _zz_n3_mtsa_round_1 = {1'b0,1'b1};
  assign _zz_n3_mtsa_round = {23'd0, _zz_n3_mtsa_round_1};
  assign _zz_when_FloatMultiplier_l144 = n4_n3_EXPN_M;
  assign _zz_when_FloatMultiplier_l146 = n4_n3_EXPN_M;
  `ifndef SYNTHESIS
  always @(*) begin
    case(n3_n2_FLAG_M)
      FloatFlag_ZERO : n3_n2_FLAG_M_string = "ZERO";
      FloatFlag_NORM : n3_n2_FLAG_M_string = "NORM";
      FloatFlag_INF : n3_n2_FLAG_M_string = "INF ";
      FloatFlag_NAN : n3_n2_FLAG_M_string = "NAN ";
      default : n3_n2_FLAG_M_string = "????";
    endcase
  end
  always @(*) begin
    case(n4_FLAG_M)
      FloatFlag_ZERO : n4_FLAG_M_string = "ZERO";
      FloatFlag_NORM : n4_FLAG_M_string = "NORM";
      FloatFlag_INF : n4_FLAG_M_string = "INF ";
      FloatFlag_NAN : n4_FLAG_M_string = "NAN ";
      default : n4_FLAG_M_string = "????";
    endcase
  end
  always @(*) begin
    case(n4_n2_FLAG_M)
      FloatFlag_ZERO : n4_n2_FLAG_M_string = "ZERO";
      FloatFlag_NORM : n4_n2_FLAG_M_string = "NORM";
      FloatFlag_INF : n4_n2_FLAG_M_string = "INF ";
      FloatFlag_NAN : n4_n2_FLAG_M_string = "NAN ";
      default : n4_n2_FLAG_M_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_FLAG_M)
      FloatFlag_ZERO : n2_FLAG_M_string = "ZERO";
      FloatFlag_NORM : n2_FLAG_M_string = "NORM";
      FloatFlag_INF : n2_FLAG_M_string = "INF ";
      FloatFlag_NAN : n2_FLAG_M_string = "NAN ";
      default : n2_FLAG_M_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_FLAG_Y)
      FloatFlag_ZERO : n2_n1_FLAG_Y_string = "ZERO";
      FloatFlag_NORM : n2_n1_FLAG_Y_string = "NORM";
      FloatFlag_INF : n2_n1_FLAG_Y_string = "INF ";
      FloatFlag_NAN : n2_n1_FLAG_Y_string = "NAN ";
      default : n2_n1_FLAG_Y_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_n1_FLAG_X)
      FloatFlag_ZERO : n2_n1_FLAG_X_string = "ZERO";
      FloatFlag_NORM : n2_n1_FLAG_X_string = "NORM";
      FloatFlag_INF : n2_n1_FLAG_X_string = "INF ";
      FloatFlag_NAN : n2_n1_FLAG_X_string = "NAN ";
      default : n2_n1_FLAG_X_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_FLAG_Y)
      FloatFlag_ZERO : n1_FLAG_Y_string = "ZERO";
      FloatFlag_NORM : n1_FLAG_Y_string = "NORM";
      FloatFlag_INF : n1_FLAG_Y_string = "INF ";
      FloatFlag_NAN : n1_FLAG_Y_string = "NAN ";
      default : n1_FLAG_Y_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_FLAG_X)
      FloatFlag_ZERO : n1_FLAG_X_string = "ZERO";
      FloatFlag_NORM : n1_FLAG_X_string = "NORM";
      FloatFlag_INF : n1_FLAG_X_string = "INF ";
      FloatFlag_NAN : n1_FLAG_X_string = "NAN ";
      default : n1_FLAG_X_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_xUpack_flag)
      FloatFlag_ZERO : n1_xUpack_flag_string = "ZERO";
      FloatFlag_NORM : n1_xUpack_flag_string = "NORM";
      FloatFlag_INF : n1_xUpack_flag_string = "INF ";
      FloatFlag_NAN : n1_xUpack_flag_string = "NAN ";
      default : n1_xUpack_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_n1_xUpack_flag)
      FloatFlag_ZERO : _zz_n1_xUpack_flag_string = "ZERO";
      FloatFlag_NORM : _zz_n1_xUpack_flag_string = "NORM";
      FloatFlag_INF : _zz_n1_xUpack_flag_string = "INF ";
      FloatFlag_NAN : _zz_n1_xUpack_flag_string = "NAN ";
      default : _zz_n1_xUpack_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_n1_xUpack_flag_1)
      FloatFlag_ZERO : _zz_n1_xUpack_flag_1_string = "ZERO";
      FloatFlag_NORM : _zz_n1_xUpack_flag_1_string = "NORM";
      FloatFlag_INF : _zz_n1_xUpack_flag_1_string = "INF ";
      FloatFlag_NAN : _zz_n1_xUpack_flag_1_string = "NAN ";
      default : _zz_n1_xUpack_flag_1_string = "????";
    endcase
  end
  always @(*) begin
    case(n1_yUpack_flag)
      FloatFlag_ZERO : n1_yUpack_flag_string = "ZERO";
      FloatFlag_NORM : n1_yUpack_flag_string = "NORM";
      FloatFlag_INF : n1_yUpack_flag_string = "INF ";
      FloatFlag_NAN : n1_yUpack_flag_string = "NAN ";
      default : n1_yUpack_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_n1_yUpack_flag)
      FloatFlag_ZERO : _zz_n1_yUpack_flag_string = "ZERO";
      FloatFlag_NORM : _zz_n1_yUpack_flag_string = "NORM";
      FloatFlag_INF : _zz_n1_yUpack_flag_string = "INF ";
      FloatFlag_NAN : _zz_n1_yUpack_flag_string = "NAN ";
      default : _zz_n1_yUpack_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_n1_yUpack_flag_1)
      FloatFlag_ZERO : _zz_n1_yUpack_flag_1_string = "ZERO";
      FloatFlag_NORM : _zz_n1_yUpack_flag_1_string = "NORM";
      FloatFlag_INF : _zz_n1_yUpack_flag_1_string = "INF ";
      FloatFlag_NAN : _zz_n1_yUpack_flag_1_string = "NAN ";
      default : _zz_n1_yUpack_flag_1_string = "????";
    endcase
  end
  always @(*) begin
    case(n2_m_flag)
      FloatFlag_ZERO : n2_m_flag_string = "ZERO";
      FloatFlag_NORM : n2_m_flag_string = "NORM";
      FloatFlag_INF : n2_m_flag_string = "INF ";
      FloatFlag_NAN : n2_m_flag_string = "NAN ";
      default : n2_m_flag_string = "????";
    endcase
  end
  always @(*) begin
    case(n4_flag)
      FloatFlag_ZERO : n4_flag_string = "ZERO";
      FloatFlag_NORM : n4_flag_string = "NORM";
      FloatFlag_INF : n4_flag_string = "INF ";
      FloatFlag_NAN : n4_flag_string = "NAN ";
      default : n4_flag_string = "????";
    endcase
  end
  `endif

  assign n0_XIN = io_xf;
  assign n0_YIN = io_yf;
  assign n1_xUpack_sign = n1_n0_XIN[31];
  assign n1_xUpack_expn = n1_n0_XIN[30 : 23];
  assign n1_xUpack_frac = n1_n0_XIN[22 : 0];
  assign n1_xUpack_mtsa = {1'b1,n1_xUpack_frac};
  assign n1_xUpack_expnAllone = (n1_xUpack_expn == 8'hff);
  assign n1_xUpack_expnEquZero = (n1_xUpack_expn == 8'h0);
  assign n1_xUpack_fracEquZero = (n1_xUpack_frac == 23'h0);
  assign _zz_n1_xUpack_flag = (n1_xUpack_fracEquZero ? FloatFlag_INF : FloatFlag_NAN);
  always @(*) begin
    if(n1_xUpack_expnAllone) begin
      n1_xUpack_flag = _zz_n1_xUpack_flag;
    end else begin
      n1_xUpack_flag = _zz_n1_xUpack_flag_1;
    end
  end

  assign _zz_n1_xUpack_flag_1 = (n1_xUpack_expnEquZero ? FloatFlag_ZERO : FloatFlag_NORM);
  assign n1_yUpack_sign = n1_n0_YIN[31];
  assign n1_yUpack_expn = n1_n0_YIN[30 : 23];
  assign n1_yUpack_frac = n1_n0_YIN[22 : 0];
  assign n1_yUpack_mtsa = {1'b1,n1_yUpack_frac};
  assign n1_yUpack_expnAllone = (n1_yUpack_expn == 8'hff);
  assign n1_yUpack_expnEquZero = (n1_yUpack_expn == 8'h0);
  assign n1_yUpack_fracEquZero = (n1_yUpack_frac == 23'h0);
  assign _zz_n1_yUpack_flag = (n1_yUpack_fracEquZero ? FloatFlag_INF : FloatFlag_NAN);
  always @(*) begin
    if(n1_yUpack_expnAllone) begin
      n1_yUpack_flag = _zz_n1_yUpack_flag;
    end else begin
      n1_yUpack_flag = _zz_n1_yUpack_flag_1;
    end
  end

  assign _zz_n1_yUpack_flag_1 = (n1_yUpack_expnEquZero ? FloatFlag_ZERO : FloatFlag_NORM);
  assign n1_SIGN_X = n1_xUpack_sign;
  assign n1_EXPN_X = n1_xUpack_expn;
  assign n1_MTSA_X = n1_xUpack_mtsa;
  assign n1_FLAG_X = n1_xUpack_flag;
  assign n1_SIGN_Y = n1_yUpack_sign;
  assign n1_EXPN_Y = n1_yUpack_expn;
  assign n1_MTSA_Y = n1_yUpack_mtsa;
  assign n1_FLAG_Y = n1_yUpack_flag;
  assign n2_m_sign = (n2_n1_SIGN_X ^ n2_n1_SIGN_Y);
  assign n2_m_mtsa = (n2_n1_MTSA_X * n2_n1_MTSA_Y);
  assign n2_m_expn = ({1'b0,_zz_n2_m_expn} - _zz_n2_m_expn_1);
  assign when_FloatMultiplier_l83 = ((((n2_n1_FLAG_X == FloatFlag_NAN) || (n2_n1_FLAG_Y == FloatFlag_NAN)) || ((n2_n1_FLAG_X == FloatFlag_ZERO) && (n2_n1_FLAG_Y == FloatFlag_INF))) || ((n2_n1_FLAG_X == FloatFlag_INF) && (n2_n1_FLAG_Y == FloatFlag_ZERO)));
  always @(*) begin
    if(when_FloatMultiplier_l83) begin
      n2_m_flag = FloatFlag_NAN;
    end else begin
      if(when_FloatMultiplier_l85) begin
        n2_m_flag = FloatFlag_INF;
      end else begin
        if(when_FloatMultiplier_l87) begin
          n2_m_flag = FloatFlag_ZERO;
        end else begin
          n2_m_flag = FloatFlag_NORM;
        end
      end
    end
  end

  assign when_FloatMultiplier_l85 = ((n2_n1_FLAG_X == FloatFlag_INF) || (n2_n1_FLAG_Y == FloatFlag_INF));
  assign when_FloatMultiplier_l87 = ((n2_n1_FLAG_X == FloatFlag_ZERO) || (n2_n1_FLAG_Y == FloatFlag_ZERO));
  assign n2_SIGN_M = n2_m_sign;
  assign n2_EXPN_M = n2_m_expn;
  assign n2_MTSA_M = n2_m_mtsa;
  assign n2_FLAG_M = n2_m_flag;
  assign when_FloatMultiplier_l105 = n3_n2_MTSA_M[47];
  always @(*) begin
    if(when_FloatMultiplier_l105) begin
      n3_mtsa_norm_1 = n3_n2_MTSA_M[47 : 1];
    end else begin
      n3_mtsa_norm_1 = n3_n2_MTSA_M[46 : 0];
    end
  end

  always @(*) begin
    if(when_FloatMultiplier_l105) begin
      n3_expn_norm_1 = (n3_n2_EXPN_M + 10'h001);
    end else begin
      n3_expn_norm_1 = n3_n2_EXPN_M;
    end
  end

  assign n3_mtsa_chop = n3_mtsa_norm_1[46 : 23];
  assign n3_round_bit = n3_mtsa_norm_1[22];
  assign n3_stick_bit = n3_mtsa_norm_1[21 : 0];
  assign when_FloatMultiplier_l117 = (n3_round_bit && ((|n3_stick_bit) || n3_mtsa_chop[0]));
  always @(*) begin
    if(when_FloatMultiplier_l117) begin
      n3_mtsa_round = ({1'b0,n3_mtsa_chop} + _zz_n3_mtsa_round);
    end else begin
      n3_mtsa_round = {1'b0,n3_mtsa_chop};
    end
  end

  assign when_FloatMultiplier_l125 = n3_mtsa_round[24];
  always @(*) begin
    if(when_FloatMultiplier_l125) begin
      n3_mtsa_norm_2 = n3_mtsa_round[24 : 1];
    end else begin
      n3_mtsa_norm_2 = n3_mtsa_round[23 : 0];
    end
  end

  always @(*) begin
    if(when_FloatMultiplier_l125) begin
      n3_expn_norm_2 = (n3_expn_norm_1 + 10'h001);
    end else begin
      n3_expn_norm_2 = n3_expn_norm_1;
    end
  end

  assign n3_EXPN_M = n3_expn_norm_2;
  assign n3_MTSA_M = n3_mtsa_norm_2;
  assign when_FloatMultiplier_l143 = (n4_n2_FLAG_M == FloatFlag_NORM);
  assign when_FloatMultiplier_l144 = ($signed(_zz_when_FloatMultiplier_l144) <= $signed(10'h0));
  always @(*) begin
    if(when_FloatMultiplier_l143) begin
      if(when_FloatMultiplier_l144) begin
        n4_flag = FloatFlag_ZERO;
      end else begin
        if(when_FloatMultiplier_l146) begin
          n4_flag = FloatFlag_INF;
        end else begin
          n4_flag = FloatFlag_NORM;
        end
      end
    end else begin
      n4_flag = n4_n2_FLAG_M;
    end
  end

  assign when_FloatMultiplier_l146 = ($signed(10'h0ff) <= $signed(_zz_when_FloatMultiplier_l146));
  always @(*) begin
    case(n4_flag)
      FloatFlag_ZERO : begin
        n4_frac = 23'h0;
      end
      FloatFlag_NORM : begin
        n4_frac = n4_n3_MTSA_M[22 : 0];
      end
      FloatFlag_INF : begin
        n4_frac = 23'h0;
      end
      default : begin
        n4_frac = 23'h7fffff;
      end
    endcase
  end

  always @(*) begin
    case(n4_flag)
      FloatFlag_ZERO : begin
        n4_expn = 8'h0;
      end
      FloatFlag_NORM : begin
        n4_expn = n4_n3_EXPN_M[7 : 0];
      end
      FloatFlag_INF : begin
        n4_expn = 8'hff;
      end
      default : begin
        n4_expn = 8'hff;
      end
    endcase
  end

  assign n4_EXPN_M = n4_expn;
  assign n4_FRAC_M = n4_frac;
  assign n4_FLAG_M = n4_flag;
  assign io_zf = {{n5_n2_SIGN_M,n5_n4_EXPN_M},n5_n4_FRAC_M};
  always @(posedge clk) begin
    n1_n0_XIN <= n0_XIN;
    n1_n0_YIN <= n0_YIN;
    n2_n1_SIGN_X <= n1_SIGN_X;
    n2_n1_EXPN_X <= n1_EXPN_X;
    n2_n1_MTSA_X <= n1_MTSA_X;
    n2_n1_FLAG_X <= n1_FLAG_X;
    n2_n1_SIGN_Y <= n1_SIGN_Y;
    n2_n1_EXPN_Y <= n1_EXPN_Y;
    n2_n1_MTSA_Y <= n1_MTSA_Y;
    n2_n1_FLAG_Y <= n1_FLAG_Y;
    n3_n2_SIGN_M <= n2_SIGN_M;
    n3_n2_EXPN_M <= n2_EXPN_M;
    n3_n2_MTSA_M <= n2_MTSA_M;
    n3_n2_FLAG_M <= n2_FLAG_M;
    n4_n2_SIGN_M <= n3_n2_SIGN_M;
    n4_n2_FLAG_M <= n3_n2_FLAG_M;
    n4_n3_EXPN_M <= n3_EXPN_M;
    n4_n3_MTSA_M <= n3_MTSA_M;
    n5_n2_SIGN_M <= n4_n2_SIGN_M;
    n5_n4_EXPN_M <= n4_EXPN_M;
    n5_n4_FRAC_M <= n4_FRAC_M;
  end


endmodule
