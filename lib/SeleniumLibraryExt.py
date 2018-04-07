from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.remote.webelement import WebElement

class SeleniumLibraryExt():
    """
    to debug:
    import sys, pdb; pdb.Pdb(stdout=sys.__stdout__).set_trace()
    """

    def get_all_texts(self, locator):
        """
        Returns the text values of all elements found by `locator`.
        """
        selib = BuiltIn().get_library_instance('SeleniumLibrary')
        elements = selib.find_elements(locator)
        return [el.text for el in elements if el]

    def scroll_element_into_view(self, locator):
        """
        Scrolls an element from given ``locator`` into view.

        Arguments:
        - ``locator``: The locator to find requested element. Key attributes for
                       arbitrary elements are ``id`` and ``name``. See `introduction` for
                       details about locating elements.

        Examples:
        | Scroll Element Into View | css:div.class |
        """
        selib = BuiltIn().get_library_instance('SeleniumLibrary')
        if isinstance(locator, WebElement):
            element = locator
        else:
	        element = selib.find_element(locator)
        assert element
        script = 'arguments[0].scrollIntoView()'
        selib._current_browser().execute_script(script, element)
        # the libriary seems to overscroll, so go up a notch 
        selib._current_browser().execute_script('window.scrollBy(0, -100)')
        return element