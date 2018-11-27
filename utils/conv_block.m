function [result] = conv_block(filter, IMSLICE)
   image_slice=im2single(IMSLICE);
   sz = size(filter);
   result = 0;
   for HGT = 1:sz(1)
      for WID = 1:sz(2)
         for CH = 1:sz(3)
             result = result + filter(HGT, WID, CH) * image_slice(WID, HGT, CH);
         end
      end
   end
end