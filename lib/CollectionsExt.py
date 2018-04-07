from robot.libraries.BuiltIn import BuiltIn

class CollectionsExt():

    def should_all_match(self, input_list, pattern, msg=None,
                            case_insensitive=False,
                            whitespace_insensitive=False):
        """
        Checks if all elements in a list match pattern
        """
        colls = BuiltIn().get_library_instance('Collections')
        matched = colls.get_matches(input_list, pattern, case_insensitive, whitespace_insensitive)

        mis_matched = set(matched).symmetric_difference(input_list) 
        if mis_matched:
            raise AssertionError('{} mismatched: {}'.format(msg, mis_matched))

        return None
