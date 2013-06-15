" 1度スクリプトを読み込んだら、2度目は読み込まない
:if &cp || exists("loaded_batch")
    :finish
:endif
:let loaded_batch = 1

" ユーザの初期設定を逃がす
:let s:save_cpo = &cpo
:set cpo&vim

" 1. 選択した範囲の行のvimスクリプトを読み込む
" 2. 一時ファイルに書き出す
" 3. 一時ファイルに書き出したvimスクリプトを実行する
" 4. 一時ファイルを削除する
:function! s:Batch() range
    " 選択した範囲の行のvimスクリプトを読み込む
    :let l:selected = getline(a:firstline, a:lastline)
    " 一時ファイルの名前を取得する
    :let l:tempfile = tempname()
    " try-finally文で確実に一時ファイルを後始末する
    :try
        " 一時ファイルに読み込んだスクリプトを書き出す
        :call writefile(l:selected, l:tempfile)
        :try
            " 一時ファイルのvimスクリプトを実行する
            :execute ":source " . l:tempfile
        :catch
            " エラー発生時は、エラーの原因とエラーの起きた場所を表示
            :echohl WarningMsg |
                \ :echo "EXCEPTION :" v:exception |
                \ :echo "THROWPOINT:" v:throwpoint |
                \ :echohl None
        :endtry
    :finally
        " ファイルを変更できるかチェック
        " （ついでにファイルがあるかどうかも）
        :if filewritable(l:tempfile)
            " 一時ファイルを削除
            :call delete(l:tempfile)
        :endif
    :endtry
:endfunction

" 行を選択して実行するコマンドBatch。s:Batch()を呼び出す
:command! -range -narg=0 Batch :<line1>,<line2>call s:Batch()

" 退避していたユーザのデータをリカバリ
:let &cpo = s:save_cpo
" スクリプトはここまで
:finish

==============================================================================
スクリプトの説明

vimスクリプトを記述した行をビジュアルモードで選択して、
:'<,'>Batch
で、選択した範囲の行のvimスクリプト文を順に実行する。

・設定ファイルの一部のみ読み込んで、結果を見たい時
・スクリプトの一部分のみ、テスト的に実行したい時
などに使用する。

==============================================================================
見るべきところ

・一時ファイルの使い方
・try-finallyの使い方
・範囲指定可能なコマンド定義、選択範囲の取得方法

==============================================================================

" vim: set ff=unix et ft=vim nowrap :

