module ApplicationHelper
    
    #For highlighting headers of column
    def css_highlighter(sort_column)
        if(params[:sort_column]==sort_column)
            return 'hilite'
        end
        
    end
    
    #For sorting Movie Title and Release date
    def sort_c(sort_column)
        
        #Sort Direction
        sort_direction = params[:sort_direction]
        if(sort_direction=="asc")
            sort_direction="desc"
        else
            sort_direction = "asc"
        end
        
        #What and how to display
        link_display = ''
        if(sort_column=='title')
            link_display = 'Movie Title'
        elsif(sort_column == 'release_date')
            link_display = 'Release Date'
        end
        
        
        link_to link_display, :sort_column => sort_column, :sort_direction => sort_direction
    end
    
end
