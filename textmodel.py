import graphlab
patent = graphlab.SFrame.read_csv(url='/Users/pjain/Downloads/thesis/matched_patents3.csv', delimiter=',', header=True, error_bad_lines=False, comment_char='', escape_char='\\', double_quote=True, quote_char='"', skip_initial_space=True, column_type_hints=None, na_values=['NA'], line_terminator='\n', usecols=[], nrows=None, skiprows=0, verbose=True, nrows_to_infer=100)


patent.head()
patent['word_count'] = graphlab.text_analytics.count_words(patent['TITLE'])

patent['word_count'] = patent['word_count'].dict_trim_by_values(2)
patent['word_count'] = patent['word_count'].dict_trim_by_keys(graphlab.text_analytics.stopwords(), exclude=True)

topics=graphlab.topic_model.create(patent['word_count'])
topics.get_topics().print_rows(num_rows=150,num_columns=10)
topics.get_topics().save('/Users/pjain/Downloads/thesis/topics','csv')
