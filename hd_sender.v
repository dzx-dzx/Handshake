module HD_SENDER #(parameter DATA_WIDTH = 32) (
    input                       clk              ,
    input                       rst              ,
    input      [DATA_WIDTH-1:0] data_src         ,
    input                       ready_output     ,
    input                       valid            ,
    input                       pipe_backup_valid,
    output reg                  valid_output     ,
    output reg                  pipe_valid       ,
    output reg [DATA_WIDTH-1:0] pipe_data
);

    always @(posedge clk) begin
        if(rst)begin
            pipe_valid <= 0;
        end
        else begin
            pipe_valid <= ready_output ? valid : pipe_valid;
        end
    end
    always @(posedge clk) begin
        if(rst)begin
            pipe_data <= 0;
        end
        else begin
            pipe_data <= ready_output ? data_src : pipe_data;
        end
    end
    always @(*) begin
        valid_output = pipe_valid || pipe_backup_valid;
    end
endmodule