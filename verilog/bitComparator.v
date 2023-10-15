module bitComparator
  (
   input wire[3:0] a, b,
   input wire sig,
   output wire lg, eq, ls
   );

   wire [4:0]  firstOne, comp;
   wire [3:0]  xorComp;

   assign xorComp = a ^ b;
   assign firstOne[4] = 1'b0;
   assign comp[4] = 1'b0;


   genvar      i;
   generate
      for(i = 3; i >= 0; i = i - 1) begin
	 assign firstOne[i] =  (firstOne[i+1] | xorComp[i])==1'b1 ? 1'b1 :
			       1'b0;
	 assign comp[i] = firstOne[i+1]==1'b1 ? comp[i+1] :
			  (firstOne[i] & a[i]) ? 1'b1     :
			  1'b0;
      end
   endgenerate
   assign eq = ~firstOne[0];
   assign lg = ~firstOne[0]==1'b1 ? 1'b0 :
	       (sig & (a[3] ^ b[3]))==1'b0 ? comp[0] :
	       ~comp[0];
   assign ls = ~firstOne[0]==1'b1 ? 1'b0 :
	       (sig & (a[3] ^ b[3]))==1'b0 ? ~comp[0] :
	       comp[0];
endmodule // bitComparator

   
   
	   
