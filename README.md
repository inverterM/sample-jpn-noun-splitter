# sample-jpn-noun-split

## About
This repository provides some sample codes for splitting Japanese nouns separated by double-byte spaces (\u3000).
Codes are introduced in the article in Qiita [URL].
If you want to split Japanese nouns separated by double-byte spaces (\u3000) such as "ほげ　ふが　ほげら太郎　42",
this repository may provide sample codes for you.

Python codes can split Japanese nouns separated by double-byte spaces (\u3000) within certain limitations.

limits:
- Nouns must have three or four double-byte spaces (\u3000).
- When nouns are split, two words must exist on both the right and left sides.

This repository provides SQL queries too.
Queries can split, but they have some limits over python codes.

limits:
- All records have the same number of double-byte spaces (\u3000).

I wish this repository will help someone's data preprocessing.

## Samples

Python codes:
```python
import pandas as pd
import japanize_matplotlib

texts = [
    'ほげ　ふが　ほげら太郎　42',
    'ほげ　ふが23　ぴよ　ほげら花子　1729',
    'ほげ　ふが23　ぴよ　ほげら花子　1984',
]

texts_splited = {
    "hoge" : [],
    "fuga" : [],
    "piyo" : [],
    "hogera" : [],
    "hogehoge" : [],
}
for text in texts:
    spl = text.split('　')
    spl_len = len(spl)
    if spl_len == 5:
        texts_splited["hoge"].append(spl[0])
        texts_splited["fuga"].append(spl[1])
        texts_splited["piyo"].append(spl[2])
        texts_splited["hogera"].append(spl[3])
        texts_splited["hogehoge"].append(spl[4])
    elif spl_len == 4:
        texts_splited["hoge"].append(spl[0])
        texts_splited["fuga"].append(spl[1])
        texts_splited["piyo"].append('None')
        texts_splited["hogera"].append(spl[2])
        texts_splited["hogehoge"].append(spl[3])

df = pd.DataFrame(texts_splited, columns=texts_splited.keys())
```

result:
|  | hoge | fuga | piyo | hogera | hogehoge |
| --: | --: | --: | --: | --: | --: |
| 0 | ほげ | ふが | None | ほげら太郎 | 42 |
| 1 | ほげ | ふが23 | ぴよ | ほげら花子 | 1729 |
| 2 | ほげ | ふが23 | ぴよ | ほげら花子 | 1984 |

This Python code can split Japanese nouns separated by double-byte spaces (\u3000).


SQL query:
```sql
SELECT texts AS name,
        SUBSTRING_INDEX(texts, '　', 1) AS name1,
        SUBSTRING_INDEX(SUBSTRING_INDEX(texts, '　', 2), '　', -1) AS name2,
        SUBSTRING_INDEX(SUBSTRING_INDEX(texts, '　', 3), '　', -1) AS name3,
        SUBSTRING_INDEX(SUBSTRING_INDEX(texts, '　', -2), '　', 1) AS name4,
        SUBSTRING_INDEX(texts, '　', -1) AS name5
    FROM sample_data;

-- +-----------------------------------------------------+--------+----------+-----------------+-----------------+-------+
-- | name                                                | name1  | name2    | name3           | name4           | name5 |
-- +-----------------------------------------------------+--------+----------+-----------------+-----------------+-------+
-- | ほげ　ふが　ほげら太郎　42                          | ほげ   | ふが     | ほげら太郎      | ほげら太郎      | 42    |
-- | ほげ　ふが23　ぴよ　ほげら花子　1729                | ほげ   | ふが23   | ぴよ            | ほげら花子      | 1729  |
-- | ほげ　ふが23　ぴよ　ほげら花子　1984                | ほげ   | ふが23   | ぴよ            | ほげら花子      | 1984  |
-- +-----------------------------------------------------+--------+----------+-----------------+-----------------+-------+
-- 3 rows in set (0.000 sec)
```

This query can split Japanese nouns separated by double-byte spaces (\u3000).
This repository has sample data and codes for sql.
The ‘SQL’ directory contains SQL codes and sample CSV files

## Licence
[The Unlicense](https://choosealicense.com/licenses/unlicense/)

This project is released under The Unlicense, 
which means it is free to use and the code is released into the public domain. 
You can use, modify, and distribute it without any restrictions.
