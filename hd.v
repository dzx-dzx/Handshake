module HD #(parameter DATA_WIDTH = 16) (
    input                       clk      ,
    input                       rst      ,
    input                       ready    ,
    input                       valid    ,
    input      [DATA_WIDTH-1:0] data_src ,
    output reg [DATA_WIDTH-1:0] data_dest,
    output ready_output
);
    reg  [DATA_WIDTH-1:0] pipe_data       ;
    reg  [DATA_WIDTH-1:0] pipe_backup     ;
    reg                   valid_output    ;
    reg                   pipe_backup_full;
    wire                  ready_output    ;

    reg ready_delay;
    always @(posedge clk) begin
        if(rst)begin
            ready_delay <= 0;
        end
        else begin
            ready_delay <= ready;
        end
    end
    assign ready_output = (ready_delay||~valid_output);


    always @(posedge clk) begin
        if(rst)begin
            valid_output <= 0;
        end
        else begin
            valid_output <= ready_output?valid:valid_output;
        end
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
            pipe_backup <= 0;
        end
        else begin
            pipe_backup <= (ready_output)?pipe_backup:pipe_data;
        end
    end
    always @(posedge clk) begin
        if(rst)begin
            pipe_backup_full <= 0;
        end
        else begin
            pipe_backup_full <= (ready_output)?~ready:pipe_backup_full;
        end
    end

    always @(posedge clk) begin
        if(rst)begin
            data_dest <= 0;
        end
        else begin
            data_dest <= (ready_delay&&valid)?(pipe_backup_full?pipe_backup:pipe_data):0;
        end
    end
endmodule