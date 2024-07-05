
# Nom de l'exécutable
NAME = cub3d

# Compilateur et options
CC = gcc
CFLAGS = -Wall -Wextra -Werror -g -O0

# Répertoires
SRC_DIR = src
OBJ_DIR = obj
MLX_DIR = ./MLX42
LIBFT_DIR = ./libft
PRINTF_DIR = ./ft_printf

# Sources et objets
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Bibliothèques
MLX_LIB = $(MLX_DIR)/build/libmlx42.a
LIBFT = $(LIBFT_DIR)/libft.a
PRINTF = $(PRINTF_DIR)/libftprintf.a

# Cible par défaut
all: $(NAME)

# Compilation de l'exécutable
$(NAME): $(OBJ) $(LIBFT) $(PRINTF) $(MLX_LIB)
	$(CC) $(CFLAGS) -o $@ $(OBJ) -L$(MLX_DIR)/build -lmlx42 -L$(LIBFT_DIR) -lft -L$(PRINTF_DIR) -lftprintf -L/usr/lib -lXext -lX11 -lm -lGL -lglfw

# Compilation des objets
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -I$(MLX_DIR)/include -I$(LIBFT_DIR) -I$(PRINTF_DIR) -MMD -MP -c $< -o $@

# Bibliothèques
$(LIBFT):
	make -C $(LIBFT_DIR)

$(PRINTF):
	make -C $(PRINTF_DIR)

$(MLX_LIB):
	cmake -B $(MLX_DIR)/build $(MLX_DIR)
	make -C $(MLX_DIR)/build

# Nettoyage
clean:
	rm -f $(OBJ)
	rm -rf $(OBJ_DIR)
	make -C $(LIBFT_DIR) clean
	make -C $(PRINTF_DIR) clean
	make -C $(MLX_DIR)/build clean

fclean: clean
	rm -f $(NAME)
	make -C $(LIBFT_DIR) fclean
	make -C $(PRINTF_DIR) fclean
	rm -rf $(MLX_DIR)/build

re: fclean all

-include $(OBJ:.o=.d)

.PHONY: all clean fclean re
