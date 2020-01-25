function Tex = tex_warp(Tex, Orient)
A = repmat(Orient,size(Tex,1),size(Tex,2)/2);
Tex = abs(A + Tex);
end