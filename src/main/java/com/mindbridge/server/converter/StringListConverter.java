// test

package com.mindbridge.server.converter;

import jakarta.persistence.AttributeConverter;
import java.io.IOException;
import java.util.List;

public class StringListConverter implements AttributeConverter<List<String>, String> {

    @Override
    public String convertToDatabaseColumn(List<String> strings) {
        return null;
    }

    @Override
    public List<String> convertToEntityAttribute(String s) {
        return null;
    }
}
