def user_map(fname):
    """ $Возвращает словарь, включающий количество слов для входного файла.$ """
    wc = 0
    with open(fname, 'r') as f:
        for line in f: wc += len(line.split())
    return { fname: wc }

def user_reduce(records):
    """ $records — коллекция словарей, возвращенных функцией map.$
        $Возвращает словарь, соответствующий файлу с макс. числом слов.$ """
    max_wc = max([rec.values()[0] for rec in records])
    for rec in records: 
        if rec.values()[0] == max_wc: return rec
