NAME = ./so_long
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))
INCLUDE_DIRS := includes
INCLUDES := $(addprefix -I, $(INCLUDE_DIRS))
SRC = $(call rwildcard,src,*.c)
OBJ := $(SRC:.c=.o)
RM = rm -f
MAKE = make
CFLAGS = -Wall -Wextra -Werror -g -fsanitize=address
CC = gcc

all: libft.a minilibx $(NAME) 

libft.a:
	make -C libs/libft/
	make bonus -C libs/libft/

minilibx:
	$(MAKE) -C libs/mlx/

%.o: %.c
	$(CC) $(CFLAGS) -Ilibs/mlx -c $^ -o $@ $(INCLUDES)

$(NAME): $(OBJ)
	$(CC) $(CFLAGS) $^ -Llibs/mlx/ -lmlx -framework OpenGL -framework AppKit -Llibs/libft/ -lft -o $@ $(INCLUDES)


clean:
	$(MAKE) clean -C ./libs/libft
	$(MAKE) -C libs/mlx/ clean
	$(RM)   $(OBJ)

fclean: clean
		$(MAKE) fclean -C ./libs/libft
		$(RM)   $(NAME)

re: fclean  all

bonus: $(NAME)

.PHONY:         all clean fclean bonus

#	$(CC) -Wall -Wextra -Werror -Imlx -c $< -o $@