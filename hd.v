module HD #(parameter DATA_WIDTH = 32) (
    input                       clk         ,
    input                       rst         ,
    input                       ready       ,
    input                       valid       ,
    input      [DATA_WIDTH-1:0] data_src    ,
    output reg [DATA_WIDTH-1:0] data_dest   ,
    output reg                  ready_output,
    output reg                  valid_output
);
    reg [DATA_WIDTH-1:0] pipe_data        ;
    reg [DATA_WIDTH-1:0] pipe_backup      ;
    reg                  pipe_valid       ;
    reg                  pipe_backup_valid;

    always @(*) begin
        ready_output = ~pipe_backup_valid;
    end

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
    always @(posedge clk) begin
        if(rst)begin
            pipe_backup <= 0;
        end
        else begin
            pipe_backup <= (ready_output && ~ready)? pipe_data : pipe_backup;
        end
    end
    always @(posedge clk) begin
        if(rst)begin
            pipe_backup_valid <= 0;
        end
        else begin
            pipe_backup_valid <= ~ready && (ready_output ? pipe_valid : pipe_backup_valid);
        end
    end
    always @(*) begin
        valid_output = pipe_valid || pipe_backup_valid;
    end
    always @(*) begin
        ready_output = ~pipe_backup_valid;
    end
    always @(*) begin
        data_dest = (pipe_backup_valid ? pipe_backup : pipe_data) ;
    end
endmodule