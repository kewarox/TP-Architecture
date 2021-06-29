NAME	= helloWorld
SRC	= hello.c
all	:	$(NAME)
$(NAME)	:
	gcc -o $(NAME) $(SRC)
clean	:
	/bin/rm -f *.o
fclean	: 	clean
	/bin/rm -f $(NAME)
re	:	fclean all
	
