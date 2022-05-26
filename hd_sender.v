module HD_SENDER #(parameter DATA_WIDTH = 32) (
    input                       clk         ,
    input                       rst         ,
    input      [DATA_WIDTH-1:0] data_src    ,
    input                       ready       ,
    input                       valid       ,
    output reg                  valid_output,
    output reg                  ready_output,
    output reg [DATA_WIDTH-1:0] data_dest
);

    always @(posedge clk) begin
        if(rst)begin
            valid_output <= 0;
        end
        else begin
            valid_output <= ready_output ? valid : valid_output;
        end
    end
    always @(posedge clk) begin
        if(rst)begin
            data_dest <= 0;
        end
        else begin
            data_dest <= ready_output ? data_src : data_dest;
        end
    end

    always @(*) begin
        ready_output = ready || ~valid_output;
    end
endmodule