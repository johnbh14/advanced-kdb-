.log.out:{-1 string[.z.T]," OUT ",x}

.log.err:{-2 string[.z.T]," ERR ",x}

.z.po:{.log.out string[.z.u]," connected - Memory Statistics: ",raze (string key .Q.w[]),'": ",/:(string value .Q.w[]),\:" "}

.z.pc:{.log.out string[.z.u]," disconnected - Memory Statistics: ",raze (string key .Q.w[]),'": ",/:(string value .Q.w[]),\:" "}
