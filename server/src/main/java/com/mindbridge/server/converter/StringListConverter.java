package com.mindbridge.server.converter;

import jakarta.persistence.AttributeConverter;
import java.util.Arrays;
import java.util.List;
public class StringListConverter implements AttributeConverter<List<String>, String>{

    private static final String SPLIT_CHAR = ", ";

    @Override
    public String convertToDatabaseColumn(List<String> stringList) {
        return String.join(SPLIT_CHAR, stringList);
    }

    @Override
    public List<String> convertToEntityAttribute(String s) {
        return Arrays.asList(toString().split(SPLIT_CHAR));
    }
}
