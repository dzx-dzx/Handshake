`include "hd.v"
module HD_tb;

// Parameters
localparam DATA_WIDTH = 16;

// Ports
reg                   clk       = 0;
reg                   rst       = 0;
reg                   ready     = 0;
reg                   valid     = 0;
reg  [DATA_WIDTH-1:0] data_src     ;
wire [DATA_WIDTH-1:0] data_dest    ;

HD #(
    .DATA_WIDTH(          
                DATA_WIDTH)  
) HD_dut (
    .clk      (clk      ),
    .rst      (rst      ),
    .ready    (ready    ),
    .valid    (valid    ),
    .data_src (data_src ),
    .data_dest(data_dest)
);

reg [1:0] test_vector[0:2];

initial begin
    clk=0;
    $dumpfile("wave.vcd");
    $dumpvars(0, HD_tb);
    data_src=1;
    @(posedge clk) rst=1;
    @(posedge clk) rst=0;
    @(posedge clk) ;
    @(posedge clk) valid=1;
    @(posedge clk) ;
    @(posedge clk) ready=1;
    @(posedge clk) ready=0;
    @(posedge clk) ;
    @(posedge clk) ;
    @(posedge clk) ;
    @(posedge clk) valid=0;
    @(posedge clk) valid=1;
    @(posedge clk) ;
    @(posedge clk) ready=1;
    @(posedge clk) ;
    @(posedge clk) ;
    @(posedge clk) ready=0;
    #50 $finish;
end

integer i = 1;
always @(posedge clk) begin
    i = i+1;
end
always @(*) begin
    if(valid&&ready) data_src=data_src+1;
end
always
    #5  clk = ! clk ;

endmodule
