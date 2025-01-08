augroup roku_project_detect
    au!
    au bufnewfile,bufread manifest,translations.ts,*.brs,*.xml call s:RokuCheck() 
augroup END

fun! s:RokuCheck()
    if glob(fnamemodify(bufname('%'), ':p:h')) != ''
        if glob(fnamemodify(bufname('%'), ':p:h') . '/source/*.brs') != '' || glob(fnamemodify(bufname('%'), ':p:h') . '/*.brs') != ''
            call s:RokuFileSetup()
        else
            let steps = ':p:h:h'
            while glob(fnamemodify(bufname('%'), steps) . '/*') != glob('//*') && glob(fnamemodify(bufname('%'), steps) . '/manifest') == ''
                let steps .= ':h'
            endwhile

            if glob(fnamemodify(bufname('%'), steps) . '/source/*.brs') != '' &&
                        \ glob(fnamemodify(bufname('%'), steps) . '/manifest') != ''
                call s:RokuFileSetup()
            endif 
        endif
    endif
endfun

fun! s:RokuFileSetup()
    com! -nargs=* -buffer RokuInstall :call installpkg#RokuInstall(<f-args>)
    com! -nargs=* -buffer RokuPackage :call installpkg#RokuPackage(<f-args>)
    com! -nargs=1 -buffer RokuRemote :call communicate#RokuRemote(<q-args>)
    com! -nargs=1 -buffer RokuMsg :call communicate#RokuMessage(<q-args>)
    if exists('g:roku_remote_keys')
        for [key, mapping] in items(g:roku_remote_keys)
            if mapping != ''
                sil! exec 'nmap <silent> <buffer> ' . mapping . ' :RokuRemote ' . key . '<cr>'
            endif
        endfor
    endif
    nnoremap <buffer> <leader>; :RokuInstall<cr>
    nnoremap <buffer> <leader>' :RokuPackage<cr>
endfun

" Add BrighterScript filetype detection
augroup filetypedetect
  au! BufRead,BufNewFile *.bs setf brighterscript
augroup END

" Load BrighterScript syntax
runtime! syntax/brighterscript.vim
