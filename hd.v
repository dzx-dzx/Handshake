module HD #(parameter DATA_WIDTH = 16) (
    input                       clk      ,
    input                       rst      ,
    input                       ready    ,
    input                       valid    ,
    input      [DATA_WIDTH-1:0] data_src ,
    output reg [DATA_WIDTH-1:0] data_dest
);
    reg  [DATA_WIDTH-1:0] pipe_data ;
    reg                   valid_output;
    wire                  ready_output;
    assign ready_output = (ready||~valid_output);
    always @(*) begin
        data_dest = (ready&&valid)?pipe_data:0;
    end
    always @(posedge clk) begin
        if(rst)begin
            pipe_data <= 0;
        end
        else begin
            pipe_data <= (ready_output&&valid)?data_src:pipe_data;
        end
    end
    always @(posedge clk) begin
        if(rst)begin
            valid_output <= 0;
        end
        else begin
            valid_output <= ready_output?valid:valid_output;
        end
    end
endmodule