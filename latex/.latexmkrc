# Set the program used to generate the PDF
# 1: pdflatex
# 2: postscript conversion, don't use this
# 3: dvi conversion, don't use this
# 4: lualatex
# 5: xelatex$pdf_mode = 1;
$pdf_mode = 1;
# 0 - 1: bbl file non-regeneratable
# 1.5: bbl file treat as non-regeneratable if bib not exist
# 2: bbl file always regeneratable
$bibtex_use = 1.5;
$latex = 'latex --src-specials %O %S';
$show_time = 1;
$out_dir = 'build';
set_tex_cmds('-synctex=1 -interaction=nonstopmode --shell-escape %O %S');

# This ensures buffer flushing, which makes output better in vimtex
STDOUT->autoflush;
STDERR->autoflush;

push @generated_exts, "cb";
push @generated_exts, "cb2";
push @generated_exts, "spl";
push @generated_exts, "nav";
push @generated_exts, "snm";
push @generated_exts, "tdo";
push @generated_exts, "nmo";
push @generated_exts, "brf";
push @generated_exts, "nlg";
push @generated_exts, "nlo";
push @generated_exts, "nls";
push @generated_exts, "auxlock";
push @generated_exts, "synctex.gz";
push @generated_exts, "fdb_latexmk";
push @generated_exts, "synctex(busy)";
push @generated_exts, "pgf-plot.*";
push @generated_exts, "run.xml";
