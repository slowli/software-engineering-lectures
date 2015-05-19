# Локальное выполнение
map_result = map(user_map, filenames)
result = reduce(lambda x, y: user_reduce((x, y)), map_result)
# Распределенное выполнение
def node_exec(node, local_files):
    """ $Выполняется на каждом вычислительном узле node$ """
    map_result = map(user_map, local_files)
    return user_reduce(map_result)
# На главном сервере
local_files = [distribute(filenames, node) for node in nodes]
local_results = [node_exec(node, files) for node, files \
    in zip(nodes, local_files)]
result = user_reduce(local_results)
