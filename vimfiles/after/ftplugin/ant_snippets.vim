
if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim


exec "Snippet proj <project name=\"".st."MyProject".et."\" default=\"".st."compile".et."\" basedir=\".\"><CR><description><CR>".st.et."<CR></description><CR><CR>".st.et."<CR><CR></project>"

exec "Snippet target <target name=\"".st.et."\" depends=\"".st.et."\" description=\"".st.et."\"><CR>".st.et."<CR></target>"

exec "Snippet javac <javac srcdir=\"".st."src".et."\" destdir=\"".st."classes".et."\"><CR>".st.et."<CR></javac><CR>".st.et
exec "Snippet javac/ <javac srcdir=\"".st."src".et."\" destdir=\"".st."classes".et."\"/><CR>".st.et
exec "Snippet java <java classname=\"".st.et."\"><CR>".st.et."<CR></java>"
exec "Snippet cp <classpath><CR>".st.et."<CR></classpath>"
exec "Snippet cpc <classpath><CR><pathelement path=\"${classpath}\"/><CR>".st.et."<CR></classpath>"
exec "Snippet path <path id=\"".st.et."\"><CR>".st.et."<CR></path>"
exec "Snippet pathr <path refid=\"".st.et."\"/><CR>".st.et
exec "Snippet pathe <pathelement location=\"".st.et."\"/><CR>".st.et
exec "Snippet pathep <pathelement path=\"${".st.et."}\"/><CR>".st.et

exec "Snippet jar <jar jarfile=\"".st.et."\"<CR>basedir=\"".st.et."\"/><CR>".st.et
exec "Snippet zip <zip destfile=\"".st.et."\"<CR>basedir=\"".st."".et."\"/><CR>".st.et

exec "Snippet copy <copy todir=\"".st.et."\"><CR>".st.et."<CR></copy>"
exec "Snippet copyd <copy todir=\"".st.et."\" file=\"".st.et."\"/><CR>".st.et
exec "Snippet copyf <copy tofile=\"".st.et."\" file=\"".st.et."\"/><CR>".st.et
exec "Snippet del <delete dir=\"\"/><CR>".st.et

exec "Snippet fs <fileset dir=\"".st.et."\"><CR>".st.et."<CR></fileset>"
exec "Snippet fs/ <fileset dir=\"".st.et."\"/><CR>".st.et
exec "Snippet inc <include name=\"".st."".et."\"/><CR>".st.et
exec "Snippet exc <exclude name=\"".st."".et."\"/><CR>".st.et





