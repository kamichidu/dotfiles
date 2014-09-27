syntax include @Pod $VIMRUNTIME/syntax/pod.vim

unlet b:current_syntax
source $VIMRUNTIME/syntax/lua.vim

syn region luaComment matchgroup=luaComment start="--\[\[" end="\]\]" contains=luaTodo,luaInnerComment,@Spell,@Pod
