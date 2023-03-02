if exists(":Neomake")
    " autorun when writing a buffer (no delay).
    call neomake#configure#automake('w')
endif

